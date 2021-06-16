class Users::PasswordsController < Devise::PasswordsController
  protected
  def after_sending_reset_password_instructions_path_for resource_name
    return teachers_root_path if resource.Teacher?

    return students_root_path if resource.Student?

    root_path
  end
end
