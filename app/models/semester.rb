class Semester < ApplicationRecord
  belongs_to :school
  has_many :study_classes, dependent: :destroy
end
