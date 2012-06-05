class UsersController < ApplicationController
  def index
    authorize! :view, User

    @users = User.all_paged(params.slice(:page, :query, :role, :active).symbolize_keys)
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	@user.role = "member"
    @user.active = true
  	if @user.save
  		cookies[:auth_token] = @user.auth_token
  		redirect_to root_url, notice: "Registered successfully!"
  	else
  		render "new"
  	end
  end
end
