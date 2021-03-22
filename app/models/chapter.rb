class Chapter < ApplicationRecord
  belongs_to :subject
  belongs_to :level
  has_many :tests, dependent: :destroy
  has_many :draft_tests, dependent: :destroy
end
