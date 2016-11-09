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

require 'test_helper'

class FileDetailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
