class SessionsController < ApplicationController
  def new
   redirect_to dashboard_path if session[:user_id]
  end


  def create
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect_to dashboard_path, notice: "Logged in!"
  else
    flash.now[:alert] = "Invalid email or password"
    render :new
  end
end

def destroy
  reset_session
  flash[:notice] = "Logged out successfully"
  redirect_to login_path, notice: "Logged out!"
end

end
