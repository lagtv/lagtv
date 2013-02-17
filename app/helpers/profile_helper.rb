module ProfileHelper
  def profile_link_to(service, user)
    url = user.url_for_service(service)
    if url.present?
      link_to "", url, :class => "#{service} icon active", :title => service.to_s.titleize
    else
      content_tag :div, "", :class => "#{service} icon disabled", :title => service.to_s.titleize
    end
  end
end