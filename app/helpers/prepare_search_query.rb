class PrepareSearchQuery
  class << self
    def prepare_query(title, location, date, category_id)
      query = "SELECT * FROM events "
      query += "WHERE " unless all_empty?(title, location, date, category_id)
      query += title_query unless title.empty?
      query += join_query(location, title)
      query += location_query unless location.empty?
      query += join_query(location, date)
      query += date_query unless date.empty?
      query += join_query(category_id, date)
      query += category_query unless category_id.empty?
      query
    end

    def all_empty?(title, location, date, category_id)
      title.empty? && location.empty? && date.empty? && category_id.empty?
    end

    def join_query(first, second)
      return " AND " unless first.empty? || second.empty?
      ""
    end

    def title_query
      "LOWER(title) LIKE :title"
    end

    def location_query
      "LOWER(location) LIKE :location"
    end

    def date_query
      "start_date Between :start_date AND :end_date"
    end

    def category_query
      "category_id = :category_id"
    end

    def prepare_popular_query
      query = "SELECT events.*, COUNT(bookings.event_id) AS num from events "
      query += "INNER JOIN bookings ON bookings.event_id = events.id "
      query += "GROUP BY events.id ORDER BY num DESC"
      query
    end
  end
end
