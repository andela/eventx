module DateFormatter
  def format_date(type)
    @date_range = []
    t = Time.zone.now
    @secs = 86_400
    today if type == "today"
    this_week if type == "this week"
    next_week if type == "next week"
    this_weekend if type == "this weekend"
    next_weekend if type == "next weekend"
    @date_range || t.now
  end

  def today
    @date_range = [t.beginning_of_day, t.end_of_day]
  end

  def tomorrow
    @date_range = t.beginning_of_day + (@secs), t.end_of_day + (secs)
  end

  def this_week
    @date_range = [t.beginning_of_week, t.end_of_week]
  end

  def next_week
    @date_range = t.beginning_of_week + (@secs * 7), t.end_of_week + (@secs * 7)
  end

  def this_weekend
    @date_range = [t.end_of_week - (@secs * 2), t.end_of_week]
  end

  def next_weekend
    @date_range = [t.end_of_week + (@secs * 5), t.end_of_week + (@secs * 7)]
  end
end
