class UsersController < ApplicationController
  def index
    authorize! :view, User

    @users = User.all_paged(params[:page], params[:query], params[:role])
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

  def edit
    @user = User.find(params[:id])

    authorize! :edit, @user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to :action => 'edit', :notice => 'Your profile as been updated'
    else
      render 'edit'
    end
  end
end
