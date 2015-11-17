module ApplicationHelper
  def signin_path(provider)
    redir_path = {origin: request.env["PATH_INFO"]}.to_query
    "/auth/#{provider.to_s}?#{redir_path}"
  end

  def create_event_or_login(name, classes)
    if current_user
      content_tag(:a, name, href:events_new_path, class: classes*" " )
    else
     content_tag(:a, name, href:"#login_modal", class: classes* " " + " modal-trigger", )
    end
  end

  def become_a_manager(name, classes)
    content_tag(:a, name, href:new_manager_profile_path, class: classes*" " )
  end

  def all_categories
   Category.order(:name)
  end

  def get_site_root_site_link
    "http://#{request.domain}:#{request.port}"
  end

  def show_form_errors(form_object)
    content = ""
    form_object.errors.full_messages.each do |err|
      content << "<li>#{err}</li>"
    end
    "<div class='row error'><ul>#{content}</ul></div>".html_safe
  end
end
