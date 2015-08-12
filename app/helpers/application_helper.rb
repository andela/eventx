module ApplicationHelper
  def signin_path(provider)
    redir_path = {origin: request.env['PATH_INFO']}.to_query
    # puts "oreoluwa #{redir_path}"
    "/auth/#{provider.to_s}?#{redir_path}"
  end

  def create_event_or_login(name, classes)
    if current_user
      content_tag(:a, name, href:events_new_path, class: classes*' ' )
    else

     #session[:url] = create_event_url

     content_tag(:a, name, href:'#login_modal', class: classes* ' ' + ' modal-trigger', )
    end
  end

  def all_categories
   Category.order(:name)
  end
end
