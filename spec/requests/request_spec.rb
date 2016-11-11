require 'rails_helper'
require 'spec_helper'

RSpec.describe 'API responses' do
  include ActionDispatch::TestProcess
  headers = { 'accept': 'application/json' }
  let(:file) { fixture_file_upload('files/test.txt', 'text/plain') }
  let(:bad_file) { fixture_file_upload('files/test.jpg', 'image/jpg') }

  describe 'GET #index' do
    before do
      # Don't want to parse the file for the factory, since there is no file to parse
      FileDetail.skip_callback(:create, :before, :parse_file)
      details = create_list(:file_detail, 3)
      get '/api/file_details', headers: headers
    end

    after do
      FileDetail.set_callback(:create, :before, :parse_file)
    end

    it 'returns a 200 status' do
      expect(response.status).to eq(200)
    end

    it 'includes a list of all FileDetails' do
      expect(json["data"].length).to eq(3)
    end
  end

  describe 'POST #create' do

    context 'with valid params' do
      before do
        post '/api/file_details', headers: headers, params: { file: file }
      end

      it 'returns a 200 status' do
        expect(response.status).to eq(200)
      end

      it 'includes the total word count' do
        expect(json_attributes["total_word_count"]).to eq(27)
      end

      it 'includes a word count mapping' do
        expect(json_attributes["word_count_map"]).not_to be_nil
      end
    end

    context 'with invalid params' do
      before do
        post '/api/file_details', headers: headers, params: { file: bad_file }
      end

      it 'returns a 422 status' do
        expect(response.status).to eq(422)
      end

      it 'renders an invalid file error message' do
        expect(json["file"]).to eq(["must be a plain text file"])
      end
    end

    context 'with no_blues set to true' do
      it 'removes words including blue from the response' do
        post '/api/file_details', headers: headers, params: { file: file, no_blues: 'true' }
        expect(json_attributes["word_count_map"]).not_to include("blue")
      end
    end

    context 'with spell check set to true' do
      it 'includes a field of spell check results' do
        post '/api/file_details', headers: headers, params: { file: file, spell_check: 'true' }
        expect(json_attributes["spell_check_results"]).not_to be_nil
      end
    end
  end
end
