Fabricator(:replay) do
  title "Super Awesome"
  description "This is a great game add should be casted asap!"
  league "silver"
  players "1v1"
  category
  replay_file {
    ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.new(Rails.root.join("spec/acceptance/support/files/Good zerg win.SC2Replay")),
      :filename => File.basename(File.new(Rails.root.join("spec/acceptance/support/files/Good zerg win.SC2Replay")))
    )
  }
  protoss true
  zerg true
end