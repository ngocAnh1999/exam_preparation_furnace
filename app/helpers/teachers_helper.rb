module TeachersHelper
  def secure_random_id
    SecureRandom.alphanumeric
  end

  def have_type_questions? object, type
    object.questions.each do |question|
      return true if question['type'] == type
    end

    return false
  end

  def show_svg(path)
    File.open("app/assets/images/#{path}", "rb") do |file|
      raw file.read
    end
  end

  def options_difficulities
    options = []
    Settings.test.difficulty.to_h.each do |key, val|
      options << [t("test.difficulty.#{key}"), val]
    end
    options
  end
end
