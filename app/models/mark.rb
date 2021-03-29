class Mark < ApplicationRecord
  belongs_to :school
  has_many :draft_tests, dependent: :destroy
  has_many :tests, dependent: :destroy
end
