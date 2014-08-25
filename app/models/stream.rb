class Stream < ActiveRecord::Base
  attr_accessible :name, :live

  def self.update_live_state
    all.each do |stream|
      poll(stream)
    end
  end

  def self.poll(stream)
    strategy = strategy_for(stream)
    stream.update_attribute(:live, strategy.live?)
  end

  def self.strategy_for(stream)
    "#{stream.provider.titleize}Stream".constantize.new(stream)
  end

  def self.streams
    streams = Stream.all.map { |s| [s.name.to_sym, s.live] }
    Hash[*streams.flatten]
  end
end
