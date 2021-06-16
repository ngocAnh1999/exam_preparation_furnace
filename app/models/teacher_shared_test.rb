class TeacherSharedTest < ApplicationRecord
  belongs_to :teacher
  belongs_to :test

  class << self
    include BulkImportable
  end
end
