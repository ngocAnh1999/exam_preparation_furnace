module TeachersHelper
  def secure_random_id
    SecureRandom.alphanumeric
  end
end
