class DraftTest < ApplicationRecord
  belongs_to :teacher
  belongs_to :chapter
  belongs_to :mark

  delegate :name, to: :chapter, prefix: true
  delegate :name, to: :mark, prefix: true
end
