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
  		cookies[:auth_token] = @user.auth_token
  		redirect_to root_url, notice: "Registered successfully!"
  	else
  		render "new"
  	end
  end

  def edit
    if params[:id].present?
      @user = User.find(params[:id])
    else
        @user = current_user
    end
      authorize! :edit, @user
    end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(filtered_params)
      redirect_to :action => 'edit', :notice => 'Your profile as been updated'
    else
      render 'edit'
    end
  end

  private
    def filtered_params
      unless can? :manage, @user
        return params[:user].slice(:email, :name, :password, :password_confirmation)
      end

      params[:user]
    end
end
