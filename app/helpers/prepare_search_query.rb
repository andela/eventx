class PrepareSearchQuery
  class << self
    def prepare_query(title = "", location = "", date = "", category_id = "")
      date_range = []
      date_range = DateFormatter.format_date(date) unless date.empty?
      location = "%" + location.downcase + "%"
      title = "%" + title.downcase + "%"
      query = events.project(Arel.sql("*"))
      unless all_empty?(title, location, date, category_id)
        query = return_match(query, "title", title) unless title.empty?
        query = return_match(query, "location", location) unless location.empty?
        query = (query.where(events[:category_id].eq(category_id))) unless
        category_id.empty?
        query = (query.where(events[:start_date].in(date_range))) unless
        date.empty?
      end
      query.to_sql
    end

    def return_match(query, column, word)
      query.where(events[column.to_sym].matches(word))
    end

    def events
      Event.arel_table
    end

    def all_empty?(title, location, date, category_id)
      title.empty? && location.empty? && date.empty? && category_id.empty?
    end

    def both_empty?(first, second)
      first.empty? || second.empty?
    end

    def bookings
      Booking.arel_table
    end

    def prepare_popular_query
      query = events.
              project(Arel.star, bookings[:event_id].count.as("num")).
              join(bookings).on(events[:id].eq(bookings[:event_id])).
              group(events[:id]).order("num DESC")
      query.to_sql
    end
  end
end
