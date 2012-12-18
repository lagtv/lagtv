class Email < ActiveRecord::Base
  attr_accessible :subject, :body, :total_sent

  validates :subject,      :presence => true,
                           :length => { :in => 1..78 }
  validates :body,         :presence => true,
                           :length => { :minimum => 5 }
  validates :roles,        :presence => true,
                           :length => { :minimum => 1 }
  validate  :roles_are_valid

  def role_list
    self.roles.split(' ')
  end

  def deliver
    UserMailer.group_message(subject, body, roles).deliver
  end

  private

  def roles_are_valid
    role_list.each do |r|
      return false unless User.ROLES.include? r
    end
    true
  end
end
