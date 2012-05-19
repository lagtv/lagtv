class User < OmniAuth::Identity::Models::ActiveRecord
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation
end