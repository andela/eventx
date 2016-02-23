class PopularQuery
  def self.bookings
    Booking.arel_table
  end

  def self.events
    Event.arel_table.where(enabled: true)
  end

  def self.build
    events.
      project(events[Arel.star], bookings[:event_id].count.as("num")).
      join(bookings).on(events[:id].eq(bookings[:event_id])).
      group(events[:id]).order("num DESC")
  end
end
