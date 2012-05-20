class User < OmniAuth::Identity::Models::ActiveRecord
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation

  validates :name,      :presence => true
  validates :password,  :presence => { :if => :password_required? },
                        :length => { :minimum => 6, :if => :password_required? }
  validates :email,     :uniqueness => true,
                        :presence => true, 
                        :email_format => true
  validates :role,      :presence => true, 
                        :inclusion => { :in => %{member community_manager admin} }

  def admin?
    role == "admin"
  end

  def community_manager?
    role == "community_manager"
  end

  def member?
    role == "member"
  end

  private
    def password_required?
      password_digest.blank? || !password.blank?
    end
end