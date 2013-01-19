class Email < ActiveRecord::Base
  attr_accessible :subject, :body, :total_sent, :role

  validates :subject, :presence => true,
                      :length => { :in => 1..78 }
  validates :body,    :presence => true,
                      :length => { :minimum => 5 }
  validates :role,    :presence => true

  def deliver
    users = User.where(:role => self.role)
      
    self.update_attribute(:started_at, Time.now)
    self.update_attribute(:total_recipients, users.count)
    
    users.each do |user|
      UserMailer.delay.group_message(self, user.email)  # according to delayed_job documentation, we don't call .deliver here
    end
  end

  def estimated_send_rate
    now = Time.now
    return 0 if started_at.blank? || now - started_at == 0
    (total_sent / (now - started_at)).round
  end

  def estimated_completion_str
    now = Time.now
    return "Never" if started_at.blank? ||
                      now - started_at == 0 ||
                      total_sent / (now - started_at) == 0
    seconds_left = ((total_recipients - total_sent) / (total_sent / (now - started_at)))
    hours = seconds_left / 3600
    minutes = seconds_left / 60
    "#{sprintf('%02d', hours)}:#{sprintf('%02d', minutes)}"
  end

  def total_remaining
    total_recipients - total_sent
  end

  def done?
    total_sent == total_recipients && !started_at.blank?
  end
end
