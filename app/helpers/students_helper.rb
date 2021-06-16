module StudentsHelper
  def student_doing_time(task)
    return task.test_doing_time*60 unless task.started_at?

    timer = (task.started_at + task.test_doing_time.minutes - Time.zone.now).to_i
    return timer if timer > 0

    0
  end

  def show_svg(path)
    File.open("app/assets/images/#{path}", "rb") do |file|
      raw file.read
    end
  end
end
