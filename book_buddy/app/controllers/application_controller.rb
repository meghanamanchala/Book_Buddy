class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :set_theme

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "You must be logged in to access this section"
    end
  end

  def set_theme
    @theme = session[:theme] || 'light'
  end

  def toggle_theme
     session[:theme] = (session[:theme] == 'dark') ? 'light' : 'dark'
     redirect_back fallback_location: root_path
  end
end
