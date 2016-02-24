class SearchQuery
  def initialize
    @query = events.project(Arel.sql("*"))
  end

  def self.build_by(search_params)
    new.build(search_params)
  end

  def build(event_name: "", event_location: "", event_date: "",
            category_id: "", enabled: "")
    append_by_match :title, event_name.downcase
    append_by_match :location, event_location.downcase
    append_by_category category_id
    append_by_date_range EventDate.format(event_date)
    append_by_enabled enabled
    @query
  end

  def append_by_match(column, word)
    @query.where(events[column].matches("%#{word}%")) unless word.empty?
  end

  def append_by_category(category_id)
    @query.where(events[:category_id].eq(category_id)) unless category_id.empty?
  end

  def append_by_date_range(range)
    empty = range.empty?
    @query.where(events[:start_date].in(range[0]..range[-1])) unless empty
  end

  def append_by_enabled(enabled)
    @query.where(events[:enabled].eq(enabled)) if enabled
  end

  def events
    Event.arel_table
  end
end