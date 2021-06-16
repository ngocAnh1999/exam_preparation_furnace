class StudyClass < ApplicationRecord
  belongs_to :semester
  belongs_to :level
  has_many :teaching_managements, dependent: :destroy
  has_many :student_study_classes, dependent: :destroy
  has_many :students, through: :student_study_classes
  has_many :section_classes, dependent: :destroy
  has_many :assigned_groups, as: :groupable, dependent: :nullify
end
