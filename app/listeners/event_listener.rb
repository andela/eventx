class EventListener
  def event_created(event)
    p "*" * 100
    p "Event Created"
    p "*" * 100
    ::Notification::Notifier.notify_subscribers(event)
  end

  def event_deleted(event)
  end

  def event_updated(event)
  end
end