class SectionClass < ApplicationRecord
  belongs_to :study_class
  belongs_to :subject
  has_many :student_section_classes, dependent: :destroy
  has_many :teacher_section_classes, dependent: :destroy
end
