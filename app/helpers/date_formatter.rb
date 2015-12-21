class DateFormatter
  attr_reader :t, :secs
  def initialize
    @t = Time.zone.now
    @secs = 86_400
  end

  def format_date(type)
    type.tr!(" ", "_")
    send(type)
  end

  def today
    [t.beginning_of_day, t.end_of_day]
  end

  def tomorrow
    [t.beginning_of_day + (secs), t.end_of_day + (secs)]
  end

  def this_week
    [t.beginning_of_week, t.end_of_week]
  end

  def next_week
    [t.beginning_of_week + (secs * 7), t.end_of_week + (secs * 7)]
  end

  def this_weekend
    [t.end_of_week - (secs * 2), t.end_of_week]
  end

  def next_weekend
    [t.end_of_week + (secs * 5), t.end_of_week + (secs * 7)]
  end
end
