class ProfileServicesController < ApplicationController
  before_filter { authorize! :manage, ProfileService }

  def index
    @profile_services = ProfileService.order("name asc")
  end

  def new
    @profile_service = ProfileService.new
  end

  def create
    @profile_service = ProfileService.new(params[:profile_service])
    if @profile_service.save
      redirect_to profile_services_path, :notice => "Profile Service added successfully"
    else
      render :new
    end
  end

  def edit
    @profile_service = ProfileService.find(params[:id])
  end

  def update
    @profile_service = ProfileService.find(params[:id])
    if @profile_service.update_attributes(params[:profile_service])
      redirect_to profile_services_path, :notice => "Profile Service updated successfully"
    else
      render :edit
    end
  end
end
