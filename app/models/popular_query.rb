class PopularQuery
  def self.bookings
    Booking.arel_table
  end

  def self.events
    Event.arel_table
  end

  def self.build
    events.
      project(events[Arel.star], bookings[:event_id].count.as("num")).
      join(bookings).on(events[:id].eq(bookings[:event_id])).
      where(events[:enabled].eq(true)).group(events[:id]).
      order("num DESC").take(9)
  end
end
