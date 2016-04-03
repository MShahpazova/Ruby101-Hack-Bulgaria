class SignOutsController < ApplicationController
  def show
   # @user = User.find_by(:id => session[:current_user_id])
   # @user = current_user
   forget(current_user)
   log_out
   redirect_to sign_in_path
  end

  private
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    # session.delete(:user_id)
    session.delete(:current_user_id)
  end
end