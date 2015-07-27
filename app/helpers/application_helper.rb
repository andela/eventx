module ApplicationHelper
  def signin_path(provider)
    redir_path = {origin: request.env['PATH_INFO']}.to_query
    # puts "oreoluwa #{redir_path}"
    "/auth/#{provider.to_s}?#{redir_path}"
  end

  def create_event_or_login(name)
    classes = ['waves-effect', 'waves-light btn-large',  'home_button']*' '
    if current_user
      content_tag(:a, name, href: events_new_path, class: classes)
    else
      content_tag(:a, name, href:'#login_modal', class: classes + ' modal-trigger' )
    end
  end
end
