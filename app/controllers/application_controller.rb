class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale
  before_filter :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user_is_admin?


  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def current_user_is_admin?
    current_user.role_slug == 'admin'
  end

  def verify_admin
    unless current_user_is_admin?
      respond_to do |format|
        format.html { render :file => 'errors/unauthorized' }
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :phone
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name

    devise_parameter_sanitizer.for(:account_update) << :phone
    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
  end

end
