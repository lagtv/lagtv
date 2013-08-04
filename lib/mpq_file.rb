require 'replay_file'

class MPQFile
  def initialize(file_path)
    file = File.new file_path
    @replay = MPQ::SC2ReplayFile.new file
    file.close
  end

  def version
    "#{@replay.game_version[:major]}.#{@replay.game_version[:minor]}.#{@replay.game_version[:patch]}"
  end

  def length_in_game_seconds
    @replay.game_length
  end
end