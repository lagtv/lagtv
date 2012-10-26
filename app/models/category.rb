class Category < ActiveRecord::Base
  has_many :replays
  attr_accessible :name, :active

  validates :name, :presence => true
  scope :ordered, order('name ASC')

  DEFAULT_FILTERS = {
    :page => 1
  }

  def self.only_active
    self.where(:active => true).ordered
  end

  def self.all_paged(options = {})
    options = options.reverse_merge(DEFAULT_FILTERS)
    self.paginate(:page => options[:page], :per_page => 25).order('name ASC')
  end
end
