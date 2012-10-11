module ApplicationHelper
  def send_replays_path(user)
    return main_app.new_replay_path if user
    main_app.login_path
  end

  def page_wrapper(&block)
    if controller_name == "pages" && action_name == "home"
      return yield
    else
      haml_tag "div", {:class => "container content"} do
        haml_tag "div", {:class => "main"} do
          haml_tag "div", {:class => "page"} do
            yield
          end
        end  
      end      
    end
  end  
end
