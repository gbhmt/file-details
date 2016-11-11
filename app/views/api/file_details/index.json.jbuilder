json.data do
  json.array! @file_details, partial: 'api/file_details/file_detail', as: :file_detail
end
