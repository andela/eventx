class EventListener
  def event_created(event)
    ::Notification::Notifier.notify_subscribers(event)
  end

  def event_deleted(event)
  end

  def event_updated(event)
  end
end