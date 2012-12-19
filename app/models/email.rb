class Email < ActiveRecord::Base
  attr_accessible :subject, :body, :total_sent, :roles

  validates :subject,      :presence => true,
                           :length => { :in => 1..78 }
  validates :body,         :presence => true,
                           :length => { :minimum => 5 }

  #validates :roles,        :presence => true,
  #                         :length => { :minimum => 1 }
  #validate  :roles_are_valid

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
      unless User::ROLES.include? r
        self.errors.add(:roles, "You must select at least one role")
        return false
      end
    end
    true
  end
end
