require 'test_helper'

class FileDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @file_detail = file_details(:one)
  end

  test "should get index" do
    get file_details_url, as: :json
    assert_response :success
  end

  test "should create file_detail" do
    assert_difference('FileDetail.count') do
      post file_details_url, params: { file_detail: { total_word_count: @file_detail.total_word_count, word_count_map: @file_detail.word_count_map } }, as: :json
    end

    assert_response 201
  end

  test "should show file_detail" do
    get file_detail_url(@file_detail), as: :json
    assert_response :success
  end

  test "should update file_detail" do
    patch file_detail_url(@file_detail), params: { file_detail: { total_word_count: @file_detail.total_word_count, word_count_map: @file_detail.word_count_map } }, as: :json
    assert_response 200
  end

  test "should destroy file_detail" do
    assert_difference('FileDetail.count', -1) do
      delete file_detail_url(@file_detail), as: :json
    end

    assert_response 204
  end
end
