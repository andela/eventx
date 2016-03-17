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
    start_date = object.start_date.strftime("%Y%m%dT%H%M%S")
    end_date = object.end_date.strftime("%Y%m%dT%H%M%S")
    'https://www.google.com/calendar/render' \
    '?action=TEMPLATE&' \
    "#{h.events_url}/#{object.id}" \
    "&text=#{object.title}&" \
    "dates=#{start_date}/#{end_date}&" \
    "details=#{object.description}&location=#{object.location}"
  end
end
