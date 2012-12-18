class Email < ActiveRecord::Base
  self.table_name = 'email'
  attr_accessible :subject, :body, :total_sent

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
    UserMailer.group_message(self).deliver
  end

  private

  def roles_are_valid
    return false if roles.blank?
    role_list.each do |r|
      return false unless User::ROLES.include? r
    end
    true
  end
end
