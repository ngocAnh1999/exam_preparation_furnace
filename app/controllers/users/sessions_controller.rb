class Users::SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    super
  end

  private

  def after_sign_in_path_for user
    flash[:success] = t "devise.sessions.signed_in"
    root_path
  end

  def after_sign_out_path_for _user
    flash[:success] = t "devise.sessions.signed_out"
    new_user_session_path
  end
end
