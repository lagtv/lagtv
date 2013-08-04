class AddGameVersionAndLengthToReplay < ActiveRecord::Migration
  def change
    add_column :replays, :version, :string
    add_column :replays, :length, :integer

    puts "Updating replay files with version and length..."
    Replay.all.each do |r|
      puts "Updating replay ##{r.id}..."
      r.update_game_details_from_replay_file
    end
    puts "Done"
  end
end
