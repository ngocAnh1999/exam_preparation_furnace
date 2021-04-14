class AssignedGroup < ApplicationRecord
  GROUPABLE_TYPE = %w(StudyClass SectionClass StudyGroup).freeze
  belongs_to :groupable, polymorphic: true
  belongs_to :test
  has_many :tasks, dependent: :destroy
end
