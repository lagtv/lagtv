class Category < ActiveRecord::Base
  has_many :replays
  attr_accessible :name

  validates :name, :presence => true

  DEFAULT_FILTERS = {
    :page => 1
  }

  def self.ordered
    self.order('name ASC')
  end

  def self.all_paged(options = {})
    options = options.reverse_merge(DEFAULT_FILTERS)
    self.paginate(:page => options[:page], :per_page => 25).order('name ASC')
  end
end
