class EventDecorator < Draper::Decorator
  # decorates :event
  delegate_all

  def image_url(version)
    object.image_url ? object.image_url(version) : ""
  end

  def start_date
    object.start_date ? object.start_date.strftime("%b %d %Y") : ""
  end

  def event_template
    object.event_template.name if object.event_template
  end

  def end_date
    object.end_date ? object.end_date.strftime("%b %d %Y") : ""
  end
end
