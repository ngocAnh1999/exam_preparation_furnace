class Test < ApplicationRecord
  belongs_to :teacher
  belongs_to :chapter
  belongs_to :mark
  has_many :question_tests, dependent: :destroy
  has_many :questions, through: :question_tests
  has_many :assigned_groups, dependent: :destroy
  has_many :teacher_shared_tests, dependent: :destroy

  enum difficulty: [:easy, :medium, :hard]
  enum shared_status: [:individual, :limited, :unlimited]

  validates :title, :start_time, :due_time, presence: true
  validate :time_in_feature
  validate :time_allowed_to_setup
  validates :title, length: { minimun: 2, maximum: 100 }
  validates :description, length: { minimum: 2, maximum: 500 }, allow_blank: true
  validates :doing_time, presence: true, unless: :unlimited_flag
  validates :doing_time, numericality: { greater_than: 4, less_than_or_equal_to: 180 }, allow_blank: true
  validates :shuffle_count, numericality: { less_than_or_equal_to: 50 }

  before_create :generate_link_share

  delegate :name, to: :chapter, prefix: true
  delegate :name, to: :mark, prefix: true

  def assign_draft_attributes draft_test
    list_attributes = %i[title description start_time due_time doing_time shuffle_count unlimited_flag teacher_id].freeze

    list_attributes.each do |attribute|
      self.send "#{attribute}=", draft_test.send(attribute)
    end
  end

  def time_in_feature
    return unless start_time? || due_time?

    time_now = Time.zone.now
    errors.add(:start_time, "Không được đặt ngày và giờ trong quá khứ") if start_time <= time_now

    errors.add(:due_time, "Không được đặt ngày và giờ trong quá khứ") if due_time <= time_now
  end

  def time_allowed_to_setup
    return unless start_time? || due_time?

    errors.add(:due_time, "Phải lớn hơn thời gian bắt đầu 5 phút") if due_time <= start_time + 5.minutes
    return unless doing_time?

    errors.add(:due_time, "Phải lớn hơn thời gian bắt đầu và thời gian làm bài") if due_time <= start_time + doing_time.minutes
  end

  private

  def generate_link_share
    self.link_share = "#{id}_#{SecureRandom.base58}"
  end
end
