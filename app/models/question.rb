class Question < ApplicationRecord
  belongs_to :teacher
  has_many :question_tests, dependent: :destroy
  has_many :answers, dependent: :destroy
end
