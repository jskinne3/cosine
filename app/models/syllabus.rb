class Syllabus < ApplicationRecord
  has_and_belongs_to_many :books

  def title
    array = [institution, field, year]
    title = array.compact.join(', ')
    (return title) unless title.blank?
    return 'no syllabus title'
  end
end
