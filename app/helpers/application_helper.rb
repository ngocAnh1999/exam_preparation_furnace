module ApplicationHelper
  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      if type == "notice"
        text = "<script>toastr.success('#{message}');</script>"
        flash_messages << text.html_safe if message
      elsif type == "alert"
        text = "<script>toastr.error('#{message}');</script>"
        flash_messages << text.html_safe if message
      end
    end
    flash_messages.join("\n").html_safe
  end

  def option_select_roles
    list = Settings.user.basic_type.to_a
    responses = []
    list.each do |key|
      val = I18n.t "users.type.select_#{key.downcase}_register"
      responses << [val, key]
    end
    responses
  end
end
