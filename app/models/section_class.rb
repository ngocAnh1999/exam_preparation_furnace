class SectionClass < ApplicationRecord
  belongs_to :study_class
  belongs_to :subject
  has_many :student_section_classes, dependent: :destroy
  has_many :teacher_section_classes, dependent: :destroy
  has_many :assigned_groups, as: :groupable, dependent: :nullify
  has_many :students, through: :student_section_classes
end
