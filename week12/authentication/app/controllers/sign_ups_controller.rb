class SignUpsController < ApplicationController
  def show
    @user = User.new
  end

  def create
     # debugger
    
    # if user_params[:password] != user_params[:password_confirmation]
    #   redirect_to sign_up_path, notice: "Passwords don't match"
    #   return
    # end

    @user = User.new(user_params)
    if @user.save
      redirect_to sign_up_path, notice: "U are now registered"
    else
      redirect_to sign_up_path, notice: @user.errors
    end 
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :password, :email, :password_confirmation)
  end
end