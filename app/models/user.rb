class User < ActiveRecord::Base
  before_create { generate_token(:auth_token) }
  before_save { profile_url.downcase! }

  has_many :replays
  has_many :comments
  has_many :profile_service_infos

  attr_accessible :email, :name, :password, :password_confirmation, :role, :active, :signature, 
                  :show_signature, :hide_others_signatures, :country, :banner, 
                  :facebook, :twitter, :you_tube, :twitch, :about_me, :remove_banner, 
                  :profile_service_infos_attributes, :profile_url
  accepts_nested_attributes_for :profile_service_infos, allow_destroy: true
  
  ROLES = %w{member analyst dev_team moderator community_manager admin}

  mount_uploader :banner, BannerUploader
  has_secure_password

  DEFAULT_FILTERS = {
    :page => 1, 
    :query => '', 
    :role => '', 
    :active => 'true'
  }

  validates :name,      :presence => true,
                        :uniqueness => true
  validates :password,  :presence => { :if => :password_required? },
                        :length => { :minimum => 6, :if => :password_required? }
  validates :email,     :uniqueness => true,
                        :presence => true, 
                        :email_format => true
  validates :role,      :presence => true, 
                        :inclusion => { :in => ROLES }

  validates :profile_url, :presence => true,
                          :uniqueness => { :case_sensitive => false },
                          :format => { :with => /^[a-zA-Z0-9_-]*$/ } 

  %w{facebook twitter twitch you_tube}.each do |service|                      
    validates service.to_sym, :format => { :with => /^[a-zA-Z0-9_-]*$/ } 
  end

  ROLES.each do |r|
    define_method "#{r}?" do
      role == r
    end
  end

  def to_s
    name
  end

  def self.build(params)
    user = User.new(params)
    user.role = "member"
    user.active = true
    user.forem_state = "approved" # all members can post in the forums
    user
  end

  def can_read_forem_forums?
    true
  end

  def can_moderate_forem_forum?(forum)
    self.admin? || self.community_manager? || self.moderator? || self.dev_team?
  end

  def forem_needs_moderation?
    true
  end

  def self.find_by_email(email_address)
    User.where('email ilike ?', email_address).first
  end

  def self.all_paged(options = {})
    options = options.reverse_merge(DEFAULT_FILTERS)

    query = "%#{options[:query]}%"
    users = self.paginate(:page => options[:page], :per_page => 25).order('created_at DESC')
    users = users.where("name ilike ? or email ilike ?", query, query) if options[:query].present?
    users = users.where(:role => options[:role]) if options[:role].present?
    users = users.where(:active => options[:active] == 'true') if options[:active].present?
    
    users
  end

  def send_password_reset
    generate_token(:password_reset_token)
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def self.authenticate_with_auth_token(auth_token)
    User
      .where(:auth_token => auth_token)
      .where(:active => true).first
  end

  def reached_weekly_replay_limit?
    self.replays.where(:created_at => 7.days.ago..Time.now.utc).count >= Replay::WEEKLY_UPLOAD_LIMIT
  end

  def build_replay(replay_args)
    raise "Weekly upload limit exceeded" if self.reached_weekly_replay_limit?

    replay = self.replays.build(replay_args)
    replay.status = 'new'
    replay.expires_at = Time.now.utc + Replay::EXPIRY_DAYS.days
    replay
  end

  def avatar_url(size)
    Gravatar.url(email, size)
  end

  def url_for_service(service)
    path = self.send(service)
    return nil if path.blank?

    tld = "com"
    tld = "tv" if service == :twitch

    "http://#{service.to_s.gsub(/_/, '')}.#{tld}/#{path}"
  end

  def self.populate_profile_urls
    User.update_all(:profile_url => nil)
    users = User.order("created_at asc")
    users.each do |user|
      profile_url = user.name.downcase.gsub(/[^a-z0-9_-]/i, '_')
      count = User.where(:profile_url => profile_url).count
      if count > 0
        count = User.where("profile_url ~ :profile_url", :profile_url => "^#{profile_url}[0-9]*$").count
        profile_url = "#{profile_url}#{count}" if count > 0
      end

      user.profile_url = profile_url
      puts "(#{user.id}) #{user.name} => #{user.profile_url}"
      user.save!
    end
  end

  private
    def password_required?
      password_digest.blank? || !password.blank?
    end
end