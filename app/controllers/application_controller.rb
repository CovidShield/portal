class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login
  around_action :switch_locale

  helper_method :current_locale
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
    @current_user = nil
  end

  def logged_in?
    current_user.present?
  end

  def admin?
    logged_in? && current_user.admin?
  end

  def switch_locale(&action)
    locale = current_user.try(:locale) || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def current_locale
    current_user.try(:locale) || I18n.default_locale
  end

  private

  def require_login
    unless logged_in?
      redirect_to login_url
    end
  end

  def require_admin
    unless admin?
      redirect_to root_url
    end
  end
end
