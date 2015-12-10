class Event < ActiveRecord::Base
  extend DateFormatter
  extend PrepareSearchQuery

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
  validates_presence_of :start_date, :end_date, :category_id

  # scope
  scope :recent_events, -> { order(created_at: :DESC).limit(12) }
  scope :featured_events, -> { order(created_at: :DESC).limit(12) }

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

  def attending?(user)
    attendees = bookings.where.not(
      payment_status: Booking.payment_statuses[:unpaid]
    ).pluck(:user_id)
    true if attendees.include?(user.id)
  end

  def self.popular_events
    find_by_sql(prepare_popular_query)
  end

  def self.search(title = "", location = "", date = "", category_id = "")
    query = prepare_query(title, location, date, category_id)
    date_range = []
    date_range = format_date(date) unless date.empty?
    find_by_sql [query, {
      title: "%" + title.downcase + "%",
      location: "%" + location.downcase + "%",
      start_date: date_range[0], end_date: date_range[-1],
      category_id: category_id
    }]
  end

  def self.upcoming_events
    time = Time.zone.now
    where("start_date >= ?", time).limit(12).order("start_date ASC")
  end

  def ticket_sold
  end
end
