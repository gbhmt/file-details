class FileDetailSerializer < ActiveModel::Serializer
  attributes :total_word_count, :word_count_map
  attribute :spell_check_results, if: :spell_check?

  def total_word_count
    if instance_options[:no_blues] == 'true'
      object.no_blues_total_word_count
    else
      object.total_word_count
    end
  end

  def word_count_map
    if instance_options[:no_blues] == 'true'
      object.no_blues_word_count_map
    else
      object.word_count_map
    end
  end

  def spell_check?
    instance_options[:spell_check] == 'true'
  end

end
