module EventsHelper

  def user_is_attending_event
    @event.attending?(current_user) if current_user
  end

  def attend_event_or_login(name, classes, additional_class_1, additional_class_2)
    button_text = name || "Attend this event"
    css_class_attend = ""
    # css_class_attend =  "show" if user_is_attending_event
    classes = classes || "modal-trigger btn waves-effect waves-light btn-large our-btn-green #{additional_class_1} #{additional_class_2}"

    if current_user
      link_to(button_text, '#purchase_ticket_modal', class: classes, data: {id: 'unattend', target: 'purchase_ticket_modal'}, id: 'attend')
    else
      link_to(button_text, '#login_modal', class: classes, data: {id: 'attend', target: 'login_modal'}, id: 'attend' )
    end
  end

  def all_template
    EventTemplate.order(:name)
  end

  def check_url(id)
    if id
      "/events/#{id}"
    else
      "/events/loading"
    end
  end

  def getMap(map_url)
    if map_url.nil? || map_url.strip.empty?
      new_map = ("https://maps.google.com/maps/place?q=Lagos,+Nigeria&ftid=0x103b8b2ae68280c1:0xdc9e87a367c3d9cb") + "&output=embed"
    else
      new_map = map_url + "&output=embed"
    end
    new_map
  end

end
