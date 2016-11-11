require 'rails_helper'
require 'byebug'

RSpec.describe '::new' do
  include ActionDispatch::TestProcess

  context 'when passed a valid text file' do

    it 'successfully creates a FileDetail instance' do
      file = fixture_file_upload('files/test.txt', 'text/plain')

      expect{ FileDetail.create!(file: file) }.to change{ FileDetail.count }.by(1)
    end
  end

  context 'when passed an invalid file' do

    it 'raises a validation error' do
      file = fixture_file_upload('files/test.jpg', 'image/jpg')

      expect{ FileDetail.create!(file: file) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end

RSpec.describe '#check_spellings' do

  it 'sets spell check results as an attribute' do
    file_detail = build(:file_detail)

    file_detail.check_spellings

    expect(file_detail.spell_check_results).to eq(['mispelled', 'bluee'])
  end
end

RSpec.describe '#omit_blues' do

  it 'sets an attribute containing the word count map without blue' do
    file_detail = build(:file_detail)

    expect(file_detail.word_count_map['bluegrass']).not_to be_nil
    file_detail.omit_blues
    expect(file_detail.no_blues_word_count_map['bluegrass']).to be_nil
  end
end
