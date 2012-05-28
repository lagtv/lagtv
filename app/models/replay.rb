class Replay < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  attr_accessible :description, :league, :players, :protoss, :terran, :title, :zerg

  LEAGUES = %w{bronze silver gold platinum diamond master grand_master}
  PLAYERS = %w{1v1 2v2 3v3 4v4 FFA}

  mount_uploader :replay_file, ReplayFileUploader

  validates :replay_file, :presence => true
  validates :title,    :presence => true
  validates :category, :presence => true
  validates :players,  :presence => true, 
                       :inclusion => { :in => PLAYERS }
  validates :league,   :presence => true, 
                       :inclusion => { :in => LEAGUES }
end
