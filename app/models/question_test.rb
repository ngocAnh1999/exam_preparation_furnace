class QuestionTest < ApplicationRecord
  belongs_to :question
  belongs_to :test

  class << self
    include BulkImportable
  end
end
