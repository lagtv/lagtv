class Category < ActiveRecord::Base
  has_many :replays
  attr_accessible :name

  validates :name, :presence => true

  def self.ordered
    self.order('name ASC')
  end
end
