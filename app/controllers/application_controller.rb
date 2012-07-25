class ApplicationController < ActionController::Base
  before_filter :miniprofiler
  
  def forem_user
    current_user
  end
  helper_method :forem_user

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => "You do not have permission to access that page"
  end

  protected
    def redirect_to_root_or_last_location(notice)
      if session[:redirect_to] && !session[:redirect_to].downcase.start_with?("http://#{request.host.downcase}")
        session[:redirect_to] = nil  # Only redirect to urls within the site
      end

      success_url = session[:redirect_to] || root_url
      redirect_to success_url, :notice => notice
      session[:redirect_to] = nil
    end

	private
    def current_user
    	@current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
    end

    def miniprofiler
      Rack::MiniProfiler.authorize_request if current_user && current_user.admin?
    end

    helper_method :current_user
end
