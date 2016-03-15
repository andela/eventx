class EventGeneratorDecorator
  def generator(generator, event)
    generator.dtstart = event.start_date.strftime("%Y%m%dT%H%M%S")
    generator.dtend = event.end_date.strftime("%Y%m%dT%H%M%S")
    generator.summary = event.title
    generator.description = event.description
    generator.location = event.location
  end

  def add_to_calendar(calendar, generator)
    calendar.add_event(generator)
    calendar.publish
  end
end
