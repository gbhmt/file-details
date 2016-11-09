class CreateFileDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :file_details do |t|
      t.integer :total_word_count, null: false
      t.text :word_count_map, null: false

      t.timestamps
    end
  end
end
