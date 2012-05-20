class UsersController < ApplicationController
  def index
    @users = User.all_paged(params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	@user.role = "member"
  	if @user.save
  		session[:user_id] = @user.id
  		redirect_to root_url, notice: "Registered successfully!"
  	else
  		render "new"
  	end
  end
end