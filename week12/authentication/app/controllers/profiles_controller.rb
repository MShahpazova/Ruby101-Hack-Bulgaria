class ProfilesController < ApplicationController
  def show
     @user = current_user
         if @user.nil?
      redirect_to sign_in_path
    end
  end
end