module EventsHelper
  def user_is_attending_event(event = @event)
    event.attending?(current_user) if current_user
  end

  def attend_event_or_login(name, classes, class_1, class_2)
    button_text = name || "Attend this event"
    classes ||= "modal-trigger btn waves-effect waves-light
    btn-large our-btn-green #{class_1} #{class_2}"
    if current_user
      link_to(
        button_text,
        "#purchase_ticket_modal",
        class: classes,
        data: { id: "unattend", target: "purchase_ticket_modal" },
        id: "attend"
      )
    else
      link_to(
        button_text,
        "#login_modal",
        class: classes,
        data: { id: "attend", target: "login_modal" },
        id: "attend"
      )
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
      tickets.max.zero? ? "Free" : number_to_currency(tickets.max, unit: "$")
    else
      "#{converter(tickets.min)} - #{converter(tickets.max)}"
    end
  end

  def past_event?(event)
    Time.now > event.end_date
  end

  def cummulative_rating(event)
    all_ratings ||= event.reviews.map(&:rating).compact
    total_rating = all_ratings.reduce(:+)
    (total_rating / all_ratings.size).round if total_rating
  end

  private

  def display_event_frequency(recurring_event)
    if recurring_event.frequency == "Daily"
      "Every Day from "
    elsif recurring_event.frequency == "Weekly"
      "Every " + recurring_event.day + " from "
    else
      "Every " + recurring_event.week + " " +
        recurring_event.day + " of the Month, from "
    end
  end

  def converter(amt)
    number_to_currency(amt, unit: "$")
  end
end
