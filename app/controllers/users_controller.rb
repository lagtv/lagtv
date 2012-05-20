class UsersController < ApplicationController
  def index
    @users = User.all_paged(params[:page], params[:query])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	@user.role = "member"
    @user.active = true
  	if @user.save
  		session[:user_id] = @user.id
  		redirect_to root_url, notice: "Registered successfully!"
  	else
  		render "new"
  	end
  end
end