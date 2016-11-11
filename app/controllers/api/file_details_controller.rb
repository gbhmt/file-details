class Api::FileDetailsController < ApplicationController

  def index
    @file_details = FileDetail.all
  end

  def create
    @file_detail = FileDetail.create_with_params(file_param, optional_params)

    if @file_detail.save
      render :show
    else
      render json: @file_detail.errors, status: 422
    end
  end

  private
  def file_param
    params.require(:file)
  end

  def optional_params
    params.permit(:no_blues, :spell_check)
  end

end
