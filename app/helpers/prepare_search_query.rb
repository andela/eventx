module PrepareSearchQuery
  def prepare_query(title, location, date, category_id)
    query = "SELECT * FROM events "
    query += "WHERE " unless title.empty? && location.empty? && date.empty? &&
                             category_id.empty?
    query += "LOWER(title) LIKE :title" unless title.empty?
    query += " AND " unless location.empty? || title.empty?
    query += "LOWER(location) LIKE :location" unless location.empty?
    query += " AND " unless location.empty? || date.empty?
    query += "start_date Between :start_date AND :end_date" unless date.empty?
    query += " AND " unless category_id.empty? || date.empty?
    query += "category_id = :category_id" unless category_id.empty?
    query
  end

  def prepare_popular_query
    query = "SELECT events.*, COUNT(bookings.event_id) AS num from events "
    query += "INNER JOIN bookings ON bookings.event_id = events.id "
    query += "GROUP BY events.id ORDER BY num DESC"
    query
  end
end
