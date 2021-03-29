class Subject < ApplicationRecord
  belongs_to :school
  has_many :section_classes, dependent: :destroy
  has_many :chapters, dependent: :destroy
end
