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
    event_staffs.inject("") do |all, staff|
      role = "(#{staff.role})" if staff.role
      user = staff.user
      img = user.profile_url
      name = "#{user.first_name} #{user.last_name}  #{role}"
      all + "<div class='chip'>
        <img src='#{img}' alt='Contact Person'>
        #{name}&emsp;<a href='/remove_staff/#{staff.id}' data-remote='true'>
        <span class='remove_staff'>x</span></a>
      </div>"
    end
  end
end
