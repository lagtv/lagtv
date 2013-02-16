module ProfileHelper
  def profile_link_to(service, user)
    url = user.url_for_service(service)
    if url.present?
      link_to "", url, :class => "#{service} icon", :title => service.titleize
    else
      content_tag :div, "", :class => "#{service} icon disabled", :title => service.titleize
    end
  end
end