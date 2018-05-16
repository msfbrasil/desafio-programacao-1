class ApplicationController < ActionController::Base

before_action :require_login, except: :login

private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    unless current_user
      redirect_to root_path
    end
  end

helper_method :current_user

end
