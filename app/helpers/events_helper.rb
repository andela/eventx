module EventsHelper
  def user_is_attending_event(event = @event)
    event.attending?(current_user) if current_user
  end

  def attend_event_or_login(name, classes, class_1, class_2)
    button_text = name || "Attend this event"
    classes ||= "modal-trigger btn waves-effect waves-light
    btn-large our-btn-green #{class_1} #{class_2}"
    if current_user
      link_to(button_text, '#purchase_ticket_modal', class:
              classes, data: { id: "unattend", target:
                "purchase_ticket_modal" }, id: "attend")
    else
      link_to(button_text, '#login_modal', class: classes, data:
              { id: "attend", target: "login_modal" }, id: "attend")
    end
  end

  def all_template
    EventTemplate.order(:name)
  end

  def getmap(map_url)
    new_map = if map_url.nil? || map_url.strip.empty?
                "https://goo.gl/ULMKDn" + "&output=embed"
              else
                map_url + "&output=embed"
              end
    new_map
  end

  def event_price(tickets, event)
    if user_is_attending_event(event)
      "Attending"
    elsif tickets.max == tickets.min
      tickets.max == 0 ? "Free" : number_to_currency(tickets.max, unit: "$")
    else
      "#{converter(tickets.min)} - #{converter(tickets.max)}"
    end
  end

  def calendar_link(event)
    start_date = Date.parse(event.start_date).strftime("%Y%m%dT%H%M%S")
    end_date = Date.parse(event.end_date).strftime("%Y%m%dT%H%M%S")
    'https://www.google.com/calendar/render' \
    '?action=TEMPLATE&' \
    "uid=#{request.protocol}#{request.host}/events/#{event.id}" \
    "&text=#{event.title}&" \
    "dates=#{start_date}/#{end_date}&" \
    "details=#{event.description}&location=#{event.location}"
  end

  private

  def converter(amt)
    number_to_currency(amt, unit: "$")
  end
end
