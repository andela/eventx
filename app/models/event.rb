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

  validate :expiration_date_cannot_be_in_the_past
  validates :title, presence: true, length: { in: 5..250 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :category_id, presence: true

  # scope
  scope :recent_events, -> { order(created_at: :DESC).limit(12) }
  scope :featured_events, -> { order(created_at: :DESC).limit(12) }

  def expiration_date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end

  def attending?(user)
    attendees = bookings.where.not(
      payment_status: Booking.payment_statuses[:unpaid]
    ).pluck(:user_id)
    true if attendees.include?(user.id)
  end

<<<<<<< HEAD
  def self.popular_events
    find_by_sql(PopularQuery.build)
=======
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
      date_range = [t.beginning_of_day, t.end_of_day]
    end
    date_range
>>>>>>> fb6f455... Added Search specs
  end

  def self.search(search_params)
    query = SearchQuery.build_by(search_params)
    find_by_sql(query)
  end

  def self.upcoming_events
    time = Time.zone.now
    where("start_date >= ?", time).limit(12).order("start_date ASC")
  end

  def ticket_sold
  end
end
