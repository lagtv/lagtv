class Stats 
  attr_reader :total_gb, :free_gb

  def initialize
    stats = Sys::Filesystem.stat("/")
    @free_gb = stats.block_size * stats.blocks_available / 1000.0 / 1000.0 / 1000.0
    @total_gb = stats.block_size * stats.blocks / 1000.0 / 1000.0 / 1000.0          
  end

  def free_space
    "#{@free_gb.round(0)}GB"
  end

  def total_space
    "#{@total_gb.round(0)}GB"
  end

  def percent_left
    "#{((free_gb / total_gb) * 100.0).round(0)}%"
  end

  def used_memory
    "#{(`ps -Ao rss=`.split.map(&:to_i).inject(&:+) / 1000.0).round(2)}MB"
  end
end