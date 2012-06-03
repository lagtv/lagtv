class UsersController < ApplicationController
  def index
    authorize! :manage, User

    @users = User.all_paged(params.slice(*User::DEFAULT_FILTERS.keys).symbolize_keys)
    @filters = params.reverse_merge(User::DEFAULT_FILTERS)
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
