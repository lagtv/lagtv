class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation, :role
  has_many :replays
  ROLES = %w{member community_manager admin}

  validates :name,      :presence => true
  validates :password,  :presence => { :if => :password_required? },
                        :length => { :minimum => 6, :if => :password_required? }
  validates :email,     :uniqueness => true,
                        :presence => true, 
                        :email_format => true
  validates :role,      :presence => true, 
                        :inclusion => { :in => ROLES }

  ROLES.each do |r|
    define_method "#{r}?" do
      role == r
    end
  end

  def self.all_paged(options = {})
    options = options.reverse_merge(:page => 1, :query => '', :role => '', :active => 'true')

    query = "%#{options[:query]}%"
    users = self.paginate(:page => options[:page], :per_page => 25).order('created_at DESC')
    users = users.where("name ilike ? or email ilike ?", query, query) if options[:query].present?
    users = users.where(:role => options[:role]) if options[:role].present?
    users = users.where(:active => options[:active] == 'true') if options[:active].present?
    
    users
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

  private
    def password_required?
      password_digest.blank? || !password.blank?
    end
end