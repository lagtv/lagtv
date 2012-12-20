module EmailsHelper
  def remaining_str(email)
    if email.started_at.blank?
      "Unknown"
    else
      email.total_remaining
    end
  end
end