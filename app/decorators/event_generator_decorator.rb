class EventGeneratorDecorator
  def initialize(event, calendar, generator)
    @event = event
    @generator = generator
    @calendar = calendar
  end

  def generator
    @generator.dtstart = @event.start_date.strftime("%Y%m%dT%H%M%S")
    @generator.dtend = @event.end_date.strftime("%Y%m%dT%H%M%S")
    @generator.summary = @event.title
    @generator.description = @event.description
    @generator.location = @event.location
  end

  def add_to_calendar
    @calendar.add_event(@generator)
    @calendar.publish
  end
end
