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
  validate :correct_file_type
  serialize :word_count_map
  before_create :parse_file

  attr_accessor :file, :no_blues_word_count_map, :no_blues_total_word_count, :spell_check_results

  def check_spellings
    response = HTTParty.post('https://api.cognitive.microsoft.com/bing/v5.0/spellcheck/',
      :query => { text: word_count_map.keys.join(" ") },
      :headers => { "Ocp-Apim-Subscription-Key" => ENV["spell_check_api_key"] })
    self.spell_check_results = response.parsed_response["flaggedTokens"].map { |el| el["token"] }
  end

  def omit_blues
    self.no_blues_word_count_map = word_count_map.reject { |word, _| word.include?("blue") }
    self.no_blues_total_word_count = no_blues_word_count_map.values.inject(:+)
  end

  private
  def correct_file_type
    if file.content_type != "text/plain"
      errors[:file] << "must be a plain text file"
    end
  end

  def parse_file
    file_contents_array = file.read.gsub(/[^a-zA-Z\s-]/, '').split
    self.total_word_count = file_contents_array.count
    self.word_count_map = map_word_counts(file_contents_array)
  end

  def map_word_counts(contents)
    word_counts = Hash.new(0)
    contents.each do |word|
      if word == 'I'
        word_counts["I"] += 1
      else
        word_counts[word.downcase] += 1
      end
    end
    word_counts
  end
end
