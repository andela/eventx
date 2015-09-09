class Event < ActiveRecord::Base
  #association
  belongs_to :category
  belongs_to :event_template
  has_one :ticket, dependent: :destroy
  accepts_nested_attributes_for :ticket
  has_many :attendees
  has_many :users, :through => :attendees

  #fileupload
  mount_uploader :image, PictureUploader

  #validation
  def expiration_date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end

   validate :expiration_date_cannot_be_in_the_past
   validates :title, presence: true, length: { in: 5..250 }
   validates :description, presence: true, length: { in: 20..1000 }
   validates :start_date, presence: true
   validates :end_date, presence: true
   validates :category_id, presence: true
   # validates :image, presence: true

  def attending?(user)
    if self.users.include?(user)
      return true
    else
      return false
    end
  end

  def self.search(title="", location="", date="")
    p title.class
    p location.class
    p date.class
    date_range = []
    date_range = self.format_date(date) unless date.empty?
    location = "%" + location + "%" unless location.empty?
    query = "SELECT * FROM events "
    query +="WHERE " unless title.empty? && location.empty? && date.empty?
    query +="title=:title" unless title.empty?
    query +=" AND " unless location.empty? || title.empty?
    query +="location LIKE :location" unless location.empty?
    query +=" AND " unless location.empty? || date.empty?
    query +="start_date Between :start_date AND :end_date" unless date.empty?

    self.find_by_sql [query, {title: title, location: location, start_date: date_range[0], end_date: date_range[-1]}]
  end


  def self.format_date(type)
    date_range = []
    t = Time.now
    case type
    when 'today'
      date_range = [t.beginning_of_day, t.end_of_day]
    when 'tomorrow'
      date_range = [t.beginning_of_day+(24*60*60), t.end_of_day+(24*60*60)]
    when 'this week'
      date_range = [t.beginning_of_week, t.end_of_week]
    when 'next week'
      date_range = [t.beginning_of_week+(24*60*60*7), t.end_of_week+(24*60*60*7)]
    when 'this weekend'
      date_range = [t.end_of_week-(24*60*60*2), t.end_of_week]
    when 'next weekend'
      date_range = [t.end_of_week+(24*60*60*5), t.end_of_week+(24*60*60*7)]
    else
      date_range = t.now
    end
  end



  #scope
  scope :recent_events, -> {order(created_at: :DESC).limit(12)}
  scope :featured_events, -> {order(created_at: :DESC).limit(2)}
  scope :popular_events, -> {order(created_at: :DESC).limit(3)}
  #scope :popular_events, -> {where('id > ?', 3).limit(3)}

end
