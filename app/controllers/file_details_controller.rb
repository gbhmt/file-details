class FileDetailsController < ApplicationController

  def index
    @file_details = FileDetail.all

    render json: @file_details
  end

  def create
    @file_detail = FileDetail.new(file_detail_params)

    if @file_detail.save
      render json: @file_detail, status: :created, location: @file_detail
    else
      render json: @file_detail.errors, status: :unprocessable_entity
    end
  end

  private
    def file_detail_params
      params.require(:file_detail).permit(:file, :no_blues, :spell_check)
    end
end
