class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => "You do not have permission to access that page"
  end

	private
    def current_user
    	@current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    helper_method :current_user
end
