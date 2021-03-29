class DraftTest < ApplicationRecord
  belongs_to :teacher
  belongs_to :chapter
  belongs_to :mark
end
