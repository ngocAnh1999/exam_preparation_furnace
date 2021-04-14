class Question < ApplicationRecord
  belongs_to :teacher
  has_many :question_tests, dependent: :destroy
  has_many :answers, inverse_of: :question

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  enum type: [:multiple_choice, :essay]
  enum databank_type: [:school, :individual]

  validates_associated :answers
  validates :content,  presence: true, length: {
    minimum: 2,
    maximum: 1000
  }

  scope :multiple_choice_questions, ->{ where type: :multiple_choice }
  scope :essay_questions, ->{ where type: :essay }
end
