class AssignedGroup < ApplicationRecord
  GROUPABLE_TYPE = %w(StudyClass SectionClass StudyGroup).freeze
  belongs_to :groupable, polymorphic: true
  belongs_to :test
  has_many :tasks, dependent: :destroy

  delegate :title, :description, :start_time, :due_time, :doing_time, :unlimited_flag,
    to: :test, prefix: true

  class << self
    include BulkImportable
  end
end
