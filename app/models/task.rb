class Task < ApplicationRecord
  belongs_to :student
  belongs_to :assigned_group

  delegate :test_title, :test_start_time, :test_due_time,
    :test_doing_time, :test_unlimited_flag, to: :assigned_group

  def unstarted?
    !started_at?
  end

  def unsubmitted?
    time_now = Time.zone.now
    time_now < test_due_time &&
      (unstarted? || !ended_at? &&
        (test_unlimited_flag || have_doing_time?(time_now)))
  end

  def submitted?
    time_now = Time.zone.now
    started_at? && ((ended_at? || time_now > test_due_time) ||
      (!test_unlimited_flag && !have_doing_time?(time_now)))
  end

  def have_doing_time?(time_now)
    tim_now < started_at + test_doing_time.minutes
  end

  def expired?
    unstarted? && Time.zone.now > test_due_time
  end
end
