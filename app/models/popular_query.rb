class PopularQuery
  def self.bookings
    Booking.arel_table
  end

  def self.events
    Event.arel_table
  end

  def self.build
    query = events.
            project(Arel.star, bookings[:event_id].count.as("num")).
            join(bookings).on(events[:id].eq(bookings[:event_id])).
            group(events[:id]).order("num DESC")
    query.to_sql
  end
end
