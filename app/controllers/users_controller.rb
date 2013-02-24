class UsersController < ApplicationController
  def show
    authorize! :view, :profile_pages
    @user = User.find_by_profile_url(params[:profile_url])

    if @user.nil?
      render :invalid_profile
    else
      @services = @user.profile_service_infos.includes(:profile_service).order('profile_services.name asc')
      @topics_started = ForumService.topics_started_by(@user)
      @topics_participated_in = ForumService.topics_with_posts_by(@user)
    end
  end

  def report_profile
    UserMailer.report_profile(params[:report]).deliver
    redirect_to root_path, :notice => "Report sent for review, thank you."
  end

  def topics
    method = params[:hint]
    raise "Invalid hint" unless %w{topics_with_posts_by topics_started_by}.include?(method)

    @user = User.find(params[:id])
    topics = ForumService.send(method, @user, params[:page])
    render :partial => 'topics', :layout => false, :locals => {:topics => topics, :hint => method}
  end

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
    authorize! :edit, @user
    
    if @user.update_attributes(filtered_params)
      redirect_to profile_path(@user.profile_url), :notice => 'Profile has been updated'
    else
      prep_view
      flash.now[:alert] = "There was a problem saving your profile, scroll down to see the errors."
      render 'edit'
    end
  end

  def mark_all_as_viewed
    current_user.last_viewed_all_at = DateTime.now.utc
    current_user.save
    redirect_to latest_posts_path, :notice => "Marked all posts as read"
  end

  def add_service
    user = User.find(params[:id])
    service = ProfileService.find(params[:service_id])
    info = ProfileServiceInfo.new(:user => user, :profile_service => service)
    render :partial => 'profile_service_form', :layout => false, 
           :locals => {:b => SimpleForm::FormBuilder.new("user[profile_service_infos_attributes][#{Time.now.to_i}]", info, view_context, {}, proc{}), :service => service}
  end

  private
    def filtered_params
      filtered = params[:user]
      if cannot? :change_role, @user
        filtered.delete(:role)
      end
      if cannot? :change_status, @user
        filtered.delete(:active)
      end
      if cannot? :change_password, @user
        filtered.delete(:password)
        filtered.delete(:password_confirmation)
      end
      if cannot?(:set_role, :admin) && params[:user][:role] == 'admin'
        filtered.delete(:role)
      end

      filtered
    end

    def get_editable_user(id)
      if id.present?
        user = User.find(id)
        authorize! :edit, user
        return user
      end
        
      current_user
    end

    def prep_view
      @replays = @user.replays.paginate(:page => params[:page], :per_page => 5).order('created_at desc')
    end
end
