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

  def google_analytics
    if CONFIG[:ga_tracker].present? 
      "<script type='text/javascript'>

      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', '#{CONFIG[:ga_tracker]}']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();

    </script>".html_safe
    end
  end

  def testing_server?
    CONFIG[:testing_server] == true
  end

  def post_path(post, current_page = :unknown)
    return "#post-#{post.id}" if current_page == "1" || current_page.nil? # Performance improvement, if we are on the first page then so must the original post
    
    "#{forem.forum_topic_path(post.topic.forum, post.topic)}?page=#{ForumService.page_post_appears_on(post)}#post-#{post.id}"
  end

  def viewed_post?(post)
    return '<i class="icon-ok" title="Viewed"></i>'.html_safe if current_user.last_viewed_all_at && post.updated_at < current_user.last_viewed_all_at
    ""
  end
end
