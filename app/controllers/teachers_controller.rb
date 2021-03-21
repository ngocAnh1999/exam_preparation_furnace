class TeachersController < ApplicationController
  layout "teachers"

  before_action :authenticate_user!

  private

  def correct_teacher
    return if current_teacher

    flash[:warning] = t "teachers.warning.not_correct"
    redirect_to root_path
  end

  def current_teacher
    current_user if current_user&.Teacher?
  end
end
