class ProfileServiceInfo < ActiveRecord::Base
  attr_accessible :profile_service, :url_suffix, :user, :username, :profile_service_id
  
  belongs_to :user
  belongs_to :profile_service

  validates :username, :presence => true
  validates :url_suffix, :presence => true, :if => Proc.new { |psi| psi.profile_service.try(:url_prefix).present? }
end
