class Task < ApplicationRecord
  belongs_to :student
  belongs_to :assigned_group

  delegate :test_title, :test_description, :test_start_time, :test_due_time,
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
    time_now < started_at + test_doing_time.minutes
  end

  def expired?
    unstarted? && Time.zone.now > test_due_time
  end

  [:multiple_choice, :essay].each do |item|
    define_method "count_#{item}" do
      count = 0
      answers.each do |ans|
        count = count+ 1 if ans["question_type"].to_i == Settings.question.type.to_h[item].to_i
      end
      count
    end
  end

  def auto_mark
    mark = 0
    answers.each do |question|
      next if question['question_type'].to_i == Settings.question.type.essay

      failed = 0
      question['answers']&.each do |answer|
        failed = failed + 1 unless answer['check'] == answer['is_correct']
      end
      mark = mark + 1 if failed == 0
    end
    mark
  end

  def update_and_map_score! task_params
    self.assign_attributes task_params
    essay_score = 0
    essay_mark = 0
    task_params[:answers].each do |question|
      if question['question_type'].to_i == Settings.question.type.essay
        essay_score = essay_score + question['score'].to_f
        essay_mark = essay_mark + question['mark'].to_f
      end
    end
    multiple_mark = auto_mark * (10 - essay_score) / count_multiple_choice

    self.score = multiple_mark + essay_mark

    save!
  end
end
