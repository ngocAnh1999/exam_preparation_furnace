class Question < ApplicationRecord
  TYPE = %i[multiple_choice essay].freeze
  DATABANK_TYPE = %i[individual school].freeze

  belongs_to :teacher
  has_many :question_tests, dependent: :destroy
  has_many :answers, inverse_of: :question

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  validates_associated :answers
  validates :content,  presence: true, length: {
    minimum: 2,
    maximum: 1000
  }

  scope :multiple_choice_questions, ->{ where type: :multiple_choice }
  scope :essay_questions, ->{ where type: :essay }
  scope :by_contents, ->(list_content){ where content: list_content }

  DATABANK_TYPE.each_with_index do |bank_type, index|
    self.class.send(:define_method, :"#{bank_type}?") do
      databank_type == index
    end
  end

  TYPE.each_with_index do |question_type, index|
    self.class.send(:define_method, :"#{question_type}?") do
      type == index
    end
  end

  class << self
    include BulkImportable
  end
end
