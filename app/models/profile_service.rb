class ProfileService < ActiveRecord::Base
  attr_accessible :logo, :name, :url_prefix
  has_many :profile_service_infos

  mount_uploader :logo, LogoUploader

  validates :name, :presence => true
end
