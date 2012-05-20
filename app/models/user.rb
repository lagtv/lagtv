class User < OmniAuth::Identity::Models::ActiveRecord
  has_secure_password
  validates_presence_of :email, :name
  validates_uniqueness_of :email

  attr_accessible :email, :name, :password, :password_confirmation
end