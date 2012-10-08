module ApplicationHelper
  def send_replays_path(user)
    return main_app.new_replay_path if user

    main_app.login_path
  end
end
