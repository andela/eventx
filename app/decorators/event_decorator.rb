class EventDecorator < Draper::Decorator
  # decorates :event
  delegate_all

  def image_url(version)
    if object.image_url
      object.image_url(version)
    else
      ""
    end
  end


  def start_date
    if object.start_date
      object.start_date.strftime("%b %d %Y")
    else
      ""
    end
  end

  def event_template
    if object.event_template
      object.event_template.name
    else
      nil
    end
  end

  def end_date
    if object.end_date
      object.end_date.strftime("%b %d %Y")
    else
      ""
    end
  end

end
