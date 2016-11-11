word_count_hash = { 'I' => 2, 'think' => 1, 'therefore' => 1, 'am' => 1,
  'blue' => 1, 'bluegrass' => 1, 'mispelled' => 1, 'bluee' => 1 }

FactoryGirl.define do
  factory :file_detail do
    total_word_count 9
    word_count_map word_count_hash
    to_create { |instance| instance.save(validate: false)}
  end
end
