class DraftTest < ApplicationRecord
  belongs_to :teacher
  with_options({on: :test}) do |for_test|
    for_test.validates :title, :start_time, :due_time, presence: true
    validate :time_in_feature
    validate :time_allowed_to_setup
    for_test.validates :title, length: { minimun: 2, maximum: 100 }
    for_test.validates :description, length: { minimum: 2, maximum: 500 }, allow_blank: true
    for_test.validates :doing_time, presence: true, unless: :unlimited_flag
    for_test.validates :doing_time, numericality: { greater_than: 4, less_than_or_equal_to: 180 }, allow_blank: true
    for_test.validates :shuffle_count, numericality: { less_than_or_equal_to: 50 }
  end

  def time_in_feature
    time_now = Time.zone.now
    errors.add(:start_time, "Không được đặt ngày và giờ trong quá khứ") if start_time? && start_time <= time_now

    errors.add(:due_time, "Không được đặt ngày và giờ trong quá khứ") if due_time? && due_time <= time_now
  end

  def time_allowed_to_setup
    return unless start_time? && due_time?

    errors.add(:due_time, "Phải lớn hơn thời gian bắt đầu 5 phút") if due_time <= start_time + 5.minutes
    return if !doing_time? || unlimited_flag?

    errors.add(:due_time, "Phải lớn hơn thời gian bắt đầu và thời gian làm bài") if due_time <= start_time + doing_time.minutes
  end
end
