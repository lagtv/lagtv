class Category < ActiveRecord::Base
  has_many :replays
  attr_accessible :name

  validates :name, :presence => true
end
