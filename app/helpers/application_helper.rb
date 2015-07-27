module ApplicationHelper
  def signin_path(provider)
    "/auth/#{provider.to_s}"
  end

  def create_event_or_login(name, classes)
    if current_user
      content_tag(:a, name, href:events_new_path, class: classes*' ' )
    else
     session[:url] = create_event_url
     content_tag(:a, name, href:'#login_modal', class: classes* ' ' + ' modal-trigger', )
    end
  end
end
