Fabricator(:profile_service) do
  name "Battle.net"
  url_prefix "http://battle.net/"
  logo {
    ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.new(Rails.root.join("spec/acceptance/support/files/logo.png")),
      :filename => File.basename(File.new(Rails.root.join("spec/acceptance/support/files/logo.png")))
    )
  }
end