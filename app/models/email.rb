class Email < ActiveRecord::Base
  attr_accessible :subject, :body, :total_sent, :roles

  validates :subject,      :presence => true,
                           :length => { :in => 1..78 }
  validates :body,         :presence => true,
                           :length => { :minimum => 5 }
  validates :roles,        :presence => true,
                           :length => { :minimum => 1 }
  validate  :roles_are_valid

  def role_list
    roles.split(' ')
  end

  def deliver
    UserMailer.group_message(self).delay.deliver
  end

  def estimated_send_rate
    now = Time.now
    return 0 if now - started_at == 0
    (total_sent / (now - started_at)).round
  end

  def estimated_completion_str
    now = Time.now
    return "Never" if now - started_at == 0 ||
                      total_sent / (now - started_at) == 0
    seconds_left = ((total_recipients - total_sent) / (total_sent / (now - started_at)))
    hours = seconds_left / 3600
    minutes = seconds_left / 60
    "#{sprintf('%02d', hours)}:#{sprintf('%02d', minutes)}"
  end

  private

  def roles_are_valid
    return false if roles.blank?
    role_list.each do |r|
      unless User::ROLES.include? r
        self.errors.add(:roles, "You must select at least one role")
        return false
      end
    end
    true
  end
end
