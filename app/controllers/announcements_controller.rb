class AnnouncementsController < ApplicationController
  def index
    authorize! :view, Announcement
    @announcements = Announcement.all_paged(params)
  end

  def new
    authorize! :new, Announcement
    @announcement = Announcement.new(:ends_at => 1.week.from_now)
  end

  def create
    authorize! :new, Announcement
    @announcement = Announcement.new(params[:announcement])
    if @announcement.save
      redirect_to announcements_path, :notice => "Successfully scheduled the announcement"
    else
      render 'new'
    end
  end

  def edit
    authorize! :edit, Announcement
    @announcement = Announcement.find(params[:id])
  end

  def update
    authorize! :edit, Announcement
    @announcement = Announcement.find(params[:id])
    if @announcement.update_attributes(params[:announcement])
      redirect_to announcements_path, :notice => "Successfully updated the announcement"
    else
      render 'edit'
    end
  end

  def destroy
    authorize! :destroy, Announcement
    Announcement.find(params[:id]).destroy
    redirect_to announcements_path, :notice => "Successfully deleted the announcement"
  end

  def hide
    ids = [params[:id], *cookies.signed[:hidden_announcement_ids]]
    cookies.permanent.signed[:hidden_announcement_ids] = ids
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
