class PasswordResetController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	user.send_password_reset if user
  	redirect_to root_url, :notice => "Email sent to reset password!"
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	if @user.update_attributes(params[:user])
  		redirect_to root_url, :notice => "Password successfully reset!"
  	else
  		render :edit
  	end
  end
end
