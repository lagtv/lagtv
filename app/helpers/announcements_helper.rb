module AnnouncementsHelper
  def current_announcements
    Announcement.current(cookies.signed[:hidden_announcement_ids])
  end
end
