class SignInsController < ApplicationController
  def show
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    
    # if @user.nil?
    #   redirect_to sign_in_path, notice: "No such user"
    #   return
        end
      # debugger

    if @user.authenticate(user_params[:password])
      redirect_to profile_path, notice: "U are now signed in"
      session[:user_id] = @user.id
       if params[:remember_me] == "1"
        cookies.permanent[:current_user_id] = @user.id
      # else
      #   # cookies.signed[:user_id] = @user.id
      # #      @user.remember
      # # cookies.permanent[:remember_token] = @user.remember_token
      # # cookies.permanent.signed[:user_id] = @user.id
       end
    else
      redirect_to sign_in_path, notice: @user.errors
    end
  end

  private

  # def remember
  #   self.remember_token = User.new_token
  #   update_attribute(:remember_digest, User.digest(remember_token))
  # end

  def user_params
    params.require(:user).permit(:password, :email)
  end
end