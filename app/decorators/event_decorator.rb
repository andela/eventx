class EventDecorator < Draper::Decorator
  # decorates :event
  delegate_all

  def image_url(version)
    object.image_url ? object.image_url(version) : ""
  end

  def start_date
    object.start_date ? object.start_date.strftime("%b %d %Y") : Time.zone.now
  end

  def event_template
    object.event_template.name if object.event_template
  end

  def end_date
    object.end_date ? object.end_date.strftime("%b %d %Y") : Time.zone.now
  end

  def get_event_staffs
    var = ""
    event_staffs.each do |staff|
      role = staff.role.to_s if staff.role
      user_role = staff.role.split("_").map(&:capitalize).join(" ")
      user = staff.user
      parameters = { user: user, role: role, user_role: user_role }
      var += h.render "users/fetch_user_info", parameters
    end
    var.html_safe
  end

  def generator
    generator = Icalendar::Event.new
    generator.dtstart = object.start_date.strftime("%Y%m%dT%H%M%S")
    generator.dtend = object.end_date.strftime("%Y%m%dT%H%M%S")
    generator.summary = object.title
    generator.description = object.description
    generator.location = object.location
    generator.uid = "#{h.events_url}/#{object.id}"
    generator
  end

  def calendar
    calendar = Icalendar::Calendar.new
    calendar.add_event(generator)
    calendar.publish
    calendar
  end

  def google_calender_link
    dtstart = event_start_date.strftime("%Y%m%dT%H%M%S")
    dtend = event_end_date.strftime("%Y%m%dT%H%M%S")

    "https://www.google.com/calendar/render" \
    "?action=TEMPLATE&" \
    "#{h.events_url}/#{event_id}" \
    "&text=#{event_title}&" \
    "dates=#{dtstart}/#{dtend}&" \
    "details=#{event_description}&location=#{event_location}"
  end

  def display_download_link
    h.link_to h.content_tag(
      :icon,
      " Add to my Calendar",
      class: "fa fa-calendar"
    ),
              event_link,
              class: "atcb-link",
              tab_index: "1",
              target: "_blank"
  end

  def display_google_link
    h.link_to h.content_tag(
      :icon,
      " Add to Google Calendar",
      class: "fa fa-google-plus"
    ),
              google_calender_link,
              class: "atcb-link",
              tab_index: "2",
              target: "_blank"
  end

  def event_link
    return "#" unless object.id
    h.generate_event_path(object)
  end

  def event_id
    return "#" unless object.id
    object.id
  end

  def event_description
    return "" unless object.description
    object.description
  end

  def event_location
    return "" unless object.location
    object.location
  end

  def event_title
    return "" unless object.title
    object.title
  end

  def event_start_date
    object.start_date ? object.start_date : Time.zone.now
  end

  def event_end_date
    object.end_date ? object.end_date : Time.zone.now
  end
end
