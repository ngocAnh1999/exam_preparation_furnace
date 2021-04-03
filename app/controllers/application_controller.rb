class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
      locale : I18n.default_locale
  end

  def self.default_url_options
    { locale: I18n.locale }
  end

  private

  def authenticate_user!
    redirect_to new_user_session_path, notice: "You must login" unless user_signed_in?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :last_name, :email, :phone])
  end

  def configure_permitted_parameters
    added_attrs = [
      :username,
      :first_name,
      :last_name,
      :email,
      :phone,
      :password,
      :password_confirmation,
      :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:username, :password]
    # TODO: backlist whitelist in user model
  end
end
