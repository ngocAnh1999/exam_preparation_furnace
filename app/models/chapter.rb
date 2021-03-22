class Chapter < ApplicationRecord
  belongs_to :subject
  belongs_to :level
  has_many :tests, dependent: :destroy
  has_many :draft_tests, dependent: :destroy

  scope :by_subject_and_level, (lambda do |subject_id, level_id|
    where(subject_id: subject_id, level_id: level_id).uniq.pluck :id, :name
  end)
end
