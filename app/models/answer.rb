class Answer < ApplicationRecord
  belongs_to :question

  validates :content, presence: true, length: { minimum: 2, maximum: 1000 }
end
