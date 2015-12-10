class EventDate
  attr_reader :t, :secs
  def initialize
    @t = Time.now
    @secs = 86_400
  end

  def self.format(date_type)
    date_type.tr!(" ", "_")
    return [] unless available? date_type.to_sym
    new.send(date_type)
  end

  def self.available?(type)
    all_types = instance_methods(false)
    all_types.include? type
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
