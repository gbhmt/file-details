class Api::FileDetailsController < ApplicationController
  rescue_from StandardError, with: :invalid_file_message

  def index
    @file_details = FileDetail.all

    render json: @file_details
  end

  def create
    @file_detail = FileDetail.new(file_detail_params)
    @file_detail.parse_file
    @file_detail.omit_blues if params[:no_blues] == 'true'
    @file_detail.check_spellings if params[:spell_check] == 'true'

    if @file_detail.save
      render json: @file_detail, no_blues: params[:no_blues], spell_check: params[:spell_check]
    else
      render json: @file_detail.errors, status: :unprocessable_entity
    end
  end

  private
    def file_detail_params
      params.require(:file_detail).permit(:file)
    end

    def invalid_file_message
      render json: [message: "Invalid file type", status: 422]
    end
end
