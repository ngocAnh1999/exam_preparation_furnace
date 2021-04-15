class Test < ApplicationRecord
  belongs_to :teacher
  has_many :question_tests, dependent: :destroy
  has_many :questions, through: :question_tests
  has_many :assigned_groups, dependent: :destroy
  has_many :teacher_shared_tests, dependent: :destroy

  enum difficulty: [:easy, :middle, :hard]
  enum shared_status: [:individual, :limited, :unlimited]

  validates :title, :start_time, :due_time, presence: true
  validates :title, length: { minimun: 2, maximum: 100 }
  validates :description, length: { minimum: 2, maximum: 500 }, allow_blank: true
  validates :doing_time, presence: true, unless: :unlimited_flag
  validates :doing_time, numericality: { greater_than: 4, less_than_or_equal_to: 180 }, allow_blank: true
  validates :shuffle_count, numericality: { less_than_or_equal_to: 50 }

  before_create :generate_link_share

  private

  def generate_link_share
    self.link_share = id + SecureRandom.base58
  end
end
