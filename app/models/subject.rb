class Subject < ApplicationRecord
  belongs_to :school
  has_many :section_classes, dependent: :destroy
  has_many :teachers, through: :section_classes
  has_many :chapters, dependent: :destroy
  has_many :group_tutors, dependent: :destroy
end
