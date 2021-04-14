class Teacher < User
  has_many :teacher_section_classes, dependent: :destroy
  has_many :section_classes, through: :teacher_section_classes
  has_many :subjects, through: :section_classes
  has_many :teaching_managements, dependent: :destroy
  has_many :study_classes, through: :teaching_managements
  has_many :classes, through: :section_classes, source: :study_class
  has_many :levels, through: :classes
  has_many :tests, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :draft_tests, dependent: :destroy
  has_many :group_tutors, dependent: :destroy
  has_many :teacher_shared_tests, dependent: :destroy
  has_many :tests, through: :teacher_shared_tests, as: :shared_tests
end
