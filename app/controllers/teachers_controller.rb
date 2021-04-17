class TeachersController < ApplicationController
  layout "teachers"

  before_action :authenticate_user!

  # rescue_from ActiveRecord::StatementInvalid do |e|
  #   flash.now[:alert] = "Thao tac cua ban da xay ra loi"
  #   redirect_to teachers_root_path
  # end

  # rescue_from NoMethodError do |e|
  #   flash.now[:alert] = "Server loi"
  #   redirect_to teachers_root_path
  # end

  # rescue_from ActiveRecord::RecordNotFound do
  #   flash.now[:alert] = "Ban ghi khong ton tai"
  #   redirect_to teachers_root_path
  # end

  private

  def correct_teacher
    return if current_teacher

    flash[:warning] = t "teachers.warning.not_correct"
    redirect_to root_path
  end

  def current_teacher
    current_user if current_user&.Teacher?
  end

  def current_school
    current_user.schools.first
  end
end
