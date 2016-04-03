def new
  
end

def create
  user = User.new(user_params)
  if user.save
    flash[:notice] = "You are now logged"
  else
  redirect_to '/login'   
end

def user_params
  params.require(:user).permit(:email, :password, :password_confirmation)
end