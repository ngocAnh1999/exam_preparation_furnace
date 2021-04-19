class StudentsController < ApplicationController
  layout "students"

  before_action :authenticate_user!

  private

  def correct_student
    return if current_student

    flash[:warning] = t "students.warning.not_correct"
    redirect_to root_path
  end

  def current_student
    current_user if current_user&.Student?
  end

  def current_school
    current_user.schools.first
  end
end
