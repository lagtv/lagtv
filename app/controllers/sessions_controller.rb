class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
      if user.active
        session[:user_id] = user.id
        redirect_to root_url, :notice => "Logged in successfully!"
      else
        flash[:error] = "Your account has been disabled! Contact administrator."
        render "new"
      end
		else
			flash[:error] = "Invalid username or password!"
			render "new"
		end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "Logged out!"
  end
end
