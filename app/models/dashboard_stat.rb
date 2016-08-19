class DashboardStat
  attr_reader :manager, :manager_events

  def initialize(manager_id)
    @manager = User.find(manager_id)
    @manager_events = @manager.events
  end

  def events_count
    manager_events.size
  end

  [:attendees, :sponsors].each do |method|
    define_method method do
      manager_events.map(&method).flatten.size
    end
  end

  def tickets_sold
    manager.bookings.map(&:user_tickets).flatten.size
  end
end
