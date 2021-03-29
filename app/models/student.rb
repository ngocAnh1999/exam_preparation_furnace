class Student < User
  has_many :student_group_tutors, dependent: :destroy
  has_many :group_tutors, through: :student_group_tutors
  has_many :student_section_classes, dependent: :destroy
  has_many :section_classes, through: :student_section_classes
  has_many :student_study_classes, dependent: :destroy
  has_many :study_classes, through: :student_study_classes
end
