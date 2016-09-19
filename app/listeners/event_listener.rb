class EventListener
  def event_created(event)
    puts  '******************************************************'
    puts "New Event #{event.title} has been created"
    puts  '******************************************************'
  end

  def event_deleted(event)
  end

  def event_updated(event)
  end
end