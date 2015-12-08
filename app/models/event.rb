class Event < ActiveRecord::Base
  belongs_to :category
  belongs_to :event_template
  has_many :ticket_types, dependent: :destroy
  accepts_nested_attributes_for :ticket_types

  has_many :bookings
  has_many :user_tickets, through: :bookings
  has_many :event_staffs
  has_many :staffs, through: :event_staffs, source: "user"
  has_many :attendees, through: :bookings, source: "user"

  belongs_to :manager_profile
  acts_as_tenant(:manager_profile)

  # fileupload
  mount_uploader :image, PictureUploader

  def all_tickets_sold
    ticket_types.where("price > 0")
  end

  def paid_tickets_sold
    user_tickets.where(payment_status: Event.statuses[:paid])
  end

  # validation
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

  def attending?(user)
    attendees = bookings.where.not(
      payment_status: Booking.payment_statuses[:unpaid]
    ).pluck(:user_id)
    true if attendees.include?(user.id)
  end

  def self.search(title = "", location = "", date = "", category_id = "")
    date_range = []
    date_range = format_date(date) unless date.empty?
    location = "%" + location + "%"
    title = "%" + title + "%"
    query = "SELECT * FROM events "
    query += "WHERE " unless title.empty? && location.empty? && date.empty?
    query += "title LIKE :title" unless title.empty?
    query += " AND " unless location.empty? || title.empty?
    query += "location LIKE :location" unless location.empty?
    query += " AND " unless location.empty? || date.empty?
    query += "start_date Between :start_date AND :end_date" unless date.empty?
    query += " AND " unless category_id.empty?
    query += "category_id = :category_id" unless category_id.empty?
    find_by_sql [query, {
      title: title, location: location,
      start_date: date_range[0], end_date: date_range[-1],
      category_id: category_id
    }]
  end

  def self.format_date(type)
    date_range = []
    t = Time.now
    secs = 86_400
    case type
    when "today"
      date_range = [t.beginning_of_day, t.end_of_day]
    when "tomorrow"
      date_range = t.beginning_of_day + (secs), t.end_of_day + (secs)
    when "this week"
      date_range = [t.beginning_of_week, t.end_of_week]
    when "next week"
      date_range = t.beginning_of_week + (secs * 7), t.end_of_week + (secs * 7)
    when "this weekend"
      date_range = [t.end_of_week - (secs * 2), t.end_of_week]
    when "next weekend"
      date_range = [t.end_of_week + (secs * 5), t.end_of_week + (secs * 7)]
    else
      date_range = t.now
    end
    date_range
  end

  # scope
  scope :recent_events, -> { order(created_at: :DESC).limit(12) }
  scope :featured_events, -> { order(created_at: :DESC).limit(12) }

  def self.popular_events
    query = "SELECT events.*, COUNT(bookings.event_id) AS num from events "
    query += "INNER JOIN bookings ON bookings.event_id = events.id "
    query += "GROUP BY events.id ORDER BY num DESC"
    find_by_sql(query)
  end

  def self.upcoming_events
    query = where("start_date >= ?", Time.zone.now)
    query.order("start_date ASC").limit(12)
  end

  def self.search_by_event_name(name)
    where("title LIKE ? ", "%#{name}%")
  end

  def ticket_sold
  end
end
