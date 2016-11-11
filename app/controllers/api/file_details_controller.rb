class Api::FileDetailsController < ApplicationController

  def index
    @file_details = FileDetail.all

    render json: @file_details
  end

  def create
    @file_detail = FileDetail.new(file: file_detail_params)

    if @file_detail.save
      @file_detail.omit_blues if params[:no_blues] == 'true'
      @file_detail.check_spellings if params[:spell_check] == 'true'
      debugger
      render json: @file_detail, no_blues: params[:no_blues], spell_check: params[:spell_check]
    else
      render json: @file_detail.errors, status: 422
    end
  end

  private
  def file_detail_params
    params.require(:file)
  end

end
