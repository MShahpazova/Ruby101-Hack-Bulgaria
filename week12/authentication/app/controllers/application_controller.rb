class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies[:current_user_id]
      @current_user ||= User.find_by(id: cookies[:current_user_id])
    end
  end   
  protect_from_forgery with: :exception
end
