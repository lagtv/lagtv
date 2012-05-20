class SessionsController < ApplicationController
  def create
  	@user = User.find_by_email(request.env['omniauth.auth'][:info][:email])
	session[:user_id] = @user.id
	redirect_to root_url, :notice => "Logged in successfully!"
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "Logged out!"
  end
end
