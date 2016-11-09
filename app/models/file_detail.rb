# == Schema Information
#
# Table name: file_details
#
#  id               :integer          not null, primary key
#  total_word_count :integer          not null
#  word_count_map   :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class FileDetail < ApplicationRecord
  validates :total_word_count, :word_count_map, presence: true

  serialize :word_count_map

  def initialize(params = {})
    parse_file(params[:file])
    omit_blues if params[:no_blues]
    spell_check if params[:spell_check]
  end

  private
  attr_reader :no_blues_word_count_map

  def parse_file(file)
    file_contents_array = file.read.split
    self.total_word_count = file_contents_array.count
    self.word_count_map = map_word_counts(file_contents_array)
  end

  def map_word_counts(contents)
    word_counts = Hash.new(0)
    contents.each { |word| word_counts[word] += 1 }
    word_counts
  end

  def spell_check
    response = HTTParty.post('https://api.cognitive.microsoft.com/bing/v5.0/spellcheck/',
      query: { text: word_count_map.values.join(" ") },
      headers: { Ocp-Apim-Subscription-Key: ENV[spell_check_api_key] })
    @spell_check_results = JSON.parse(response).flaggedTokens.map { |el| el.token }
  end

  def omit_blues
    @no_blues_word_count_map = word_count_map.reject { |word, _ | word.include?("blue") }
    @no_blues_total_word_count = no_blues_word_count_map.values.inject(:+)
  end
end
