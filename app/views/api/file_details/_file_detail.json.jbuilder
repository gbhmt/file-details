json.id file_detail.id
json.type 'file_detail'
json.attributes do
  if params[:no_blues] == 'true'
    json.total_word_count file_detail.no_blues_total_word_count
    json.word_count_map file_detail.no_blues_word_count_map
  else
    json.extract! file_detail, :total_word_count, :word_count_map
  end
  if params[:spell_check] == 'true'
    json.spell_check_results file_detail.spell_check_results
  end
end
