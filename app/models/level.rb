class Level < ApplicationRecord
  belongs_to :school
  has_many :chapters, dependent: :destroy
  has_many :study_classes, dependent: :destroy
end
