module ApplicationHelper
  def signin_path(provider)
    "/auth/#{provider}"
  end

  def create_event_or_login(name, classes)
    if current_user
      content_tag(:a, name, href: new_event_path, class: classes * " ")
    else
      content_tag(:a, name, href: "#login_modal", class:
                  classes * " " + " modal-trigger")
    end
  end

  def become_a_manager(name, classes)
    content_tag(:a, name, href: new_manager_profile_path, class: classes * " ")
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

  def message_link(messages)
    if messages.unread.count.zero?
      "Inbox<span class='badge'>#{messages.count}</span>".html_safe
    else
      "Inbox<span class='new badge'>#{messages.unread.count}</span>".html_safe
    end
  end
end
