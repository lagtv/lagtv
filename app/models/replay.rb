class Replay < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  attr_accessible :description, :league, :players, :protoss, :terran, :title, :zerg, :replay_file, :category_id

  LEAGUES = %w{bronze silver gold platinum diamond master grand_master}
  PLAYERS = %w{1v1 2v2 3v3 4v4 FFA}
  STATUSES = %w{new rejected suggested broadcasted}
  EXPIRY_DAYS = 14
  WEEKLY_UPLOAD_LIMIT = 3

  mount_uploader :replay_file, ReplayFileUploader

  validates :replay_file, :presence => true
  validates :title,       :presence => true
  validates :category_id, :presence => true
  validates :user_id,     :presence => true
  validates :expires_at,  :presence => true
  validates :players,     :presence => true,
                          :inclusion => { :in => PLAYERS }
  validates :league,      :presence => true, 
                          :inclusion => { :in => LEAGUES }
  validates :status,      :presence => true, 
                          :inclusion => { :in => STATUSES }

  def self.all_paged(options)
    options = options.reverse_merge(:page => 1)
    users = self.paginate(:page => options[:page], :per_page => 25).order('created_at DESC')
    users
  end
end
