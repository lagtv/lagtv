class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :replay

  attr_accessible :text

  validates :text,      :presence => true
  validates :replay_id, :presence => true
  validates :user_id,   :presence => true
end
