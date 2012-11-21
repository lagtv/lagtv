class SessionsController < ApplicationController
  def new
    session[:redirect_to] = request.env["HTTP_REFERER"]
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    remember_me = params[:session][:remember_me]

  	user = User.find_by_email(email)
  	if user && user.authenticate(password)
      if user.active
        if remember_me
          cookies.permanent[:auth_token] = user.auth_token
        else
          cookies[:auth_token] = user.auth_token
        end

        redirect_to_root_or_last_location "Logged in successfully!"
      else
        flash.now[:alert] = "Your account has been disabled! Contact administrator."
        render "new"
      end
		else
			flash.now[:alert] = "Invalid username or password!"
			render "new"
		end
  end

  def destroy
  	cookies.delete(:auth_token)
  	redirect_to root_url, :notice => "Logged out!"
  end
end
