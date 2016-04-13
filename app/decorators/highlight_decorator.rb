class HighlightDecorator < Draper::Decorator
  delegate_all

  def image_url(version = :landing)
    object.image_url ? object.image_url(version) : ""
  end

  def day
    object.day.strftime('%a %B %d, %Y')
  end

  def start_time
    object.start_time ? object.start_time.strftime("%I:%M %p") : Time.zone.now
  end

  def end_time
    object.end_time ? object.end_time.strftime("%I:%M %p") : Time.zone.now
  end
end
