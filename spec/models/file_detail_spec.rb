require 'rails_helper'

RSpec.describe 'FileDetail' do

  describe '::create_with_params' do
    include ActionDispatch::TestProcess

    context 'when passed a valid text file' do

      it 'successfully creates a FileDetail instance' do
        file = fixture_file_upload('files/test.txt', 'text/plain')

        expect{ FileDetail.create_with_params(file) }.to change{ FileDetail.count }.by(1)
      end
    end

    context 'when passed an invalid file' do

      it 'adds errors to the FileDetail instance' do
        file = fixture_file_upload('files/test.jpg', 'image/jpg')
        file_detail = FileDetail.create_with_params(file)
        expect(file_detail.errors["file"]).not_to be_empty
      end
    end

    context 'when passed no_blues=true' do

      it 'sets an attribute containing the word count map without words containing blue' do
        file = fixture_file_upload('files/test.txt', 'text/plain')
        file_detail = FileDetail.create_with_params(file, no_blues: 'true')

        expect(file_detail.no_blues_total_word_count).not_to be_nil
        expect(file_detail.no_blues_word_count_map['bluegrass']).to be_nil
      end
    end

    context 'when passed spell_check=true' do

      it 'sets spell check results as an attribute' do
        file = fixture_file_upload('files/test.txt', 'text/plain')
        file_detail = FileDetail.create_with_params(file, spell_check: 'true')

        expect(file_detail.spell_check_results).to eq(['mispelled', 'liek', 'ths'])
      end
    end
  end
end
