class UsersController < ApplicationController
  def index
    authorize! :manage, User

    @users = User.all_paged(params.slice(*User::DEFAULT_FILTERS.keys).symbolize_keys)
    @filters = params.reverse_merge(User::DEFAULT_FILTERS)
  end

  def new
    if current_user
      redirect_to root_path
    end

  	@user = User.new
    @is_human = IsHuman.new(@user)

    render :layout => false if request.xhr?
  end

  def create
    if IsHuman.correct?(params[:user])
    	@user = User.build(params[:user])

    	if @user.save
    		cookies[:auth_token] = @user.auth_token
    		redirect_to_root_or_last_location "Registered successfully!"
    	else
    		render "new"
    	end
    else
      # Is human test failed
      @user = User.new(params[:user])
      @is_human = IsHuman.new(@user)
      flash.now[:alert] = "We don't think you are human, please try again."
      render "new"
    end
  end

  def edit
    @user = get_editable_user(params[:id])
    authorize! :edit, @user
    prep_view
  end

  def update
    @user = get_editable_user(params[:id])
    
    if @user.update_attributes(filtered_params)
      handle_redirect
    else
      prep_view
      render 'edit'
    end
  end

  private
    def filtered_params
      filtered = params[:user]
      if cannot? :change_role, @user
        filtered.slice!(:email, :name, :password, :password_confirmation, :active)
      end
      if cannot? :change_status, @user
        filtered.slice!(:email, :name, :password, :password_confirmation)
      end
      if cannot? :change_password, @user
        filtered.slice!(:email, :name)
      end

      filtered
    end

    def get_editable_user(id)
      if id.present? and can? :manage, User
        return User.find(id)
      end
      if id.present? and cannot? :manage, User
        raise CanCan::AccessDenied.new
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

    def prep_view
      @replays = @user.replays.paginate(:page => params[:page], :per_page => 5).order('created_at desc')
    end
end
