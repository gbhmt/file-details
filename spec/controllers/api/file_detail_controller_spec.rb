require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::FileDetailsController do
  before :each do
    request.headers["accept"] = 'application/json'
  end

  describe "GET #index" do
    it 'renders the :index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "POST #create" do
    let(:file) { fixture_file_upload('files/test.txt', 'text/plain') }

    context 'with valid file param' do

      it 'creates a new FileDetail instance' do
        expect{ post :create, params: { file: file } }.to change{ FileDetail.count }.by(1)
      end

      it 'renders the show template' do
        post :create, params: { file: file }
        expect(response).to render_template(:show)
      end
    end

    context 'with invalid file param' do
      let(:file) { file = fixture_file_upload('files/test.jpg', 'image/jpg') }

      it 'renders the appropriate errors' do
        post :create, params: { file: file }
        expect(json["file"]).to eq(["must be a plain text file"])
      end
    end
  end
end
