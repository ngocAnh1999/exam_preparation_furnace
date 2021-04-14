class TeacherSectionClass < ApplicationRecord
  belongs_to :teacher
  belongs_to :section_class
end
