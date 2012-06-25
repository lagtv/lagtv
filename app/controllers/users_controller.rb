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
    @user = get_editable_user(params[:id])
    authorize! :edit, @user
  end

  def update
    @user = get_editable_user(params[:id])
    
    if @user.update_attributes(filtered_params)
      handle_redirect
    else
      render 'edit'
    end
  end

  private
    def filtered_params
      unless can? :change_role, @user
        return params[:user].slice(:email, :name, :password, :password_confirmation)
      end

      params[:user]
    end

    def get_editable_user(id)
      if id.present? and can? :manage, User
        return User.find(id)
      end
        
      current_user
    end

    def handle_redirect
      if can? :manage, User
        redirect_to users_path, :notice => 'User has been updated'
      else
        redirect_to my_profile_path, :notice => 'Your profile as been updated'
      end
    end
end
