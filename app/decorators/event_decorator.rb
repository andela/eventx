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
end
