class Event < ActiveRecord::Base
  belongs_to :category
  belongs_to :event_template
  has_many :ticket_types, dependent: :destroy
  has_many :event_staffs, dependent: :destroy
  has_many :staffs, through: :event_staffs, source: "user"
  accepts_nested_attributes_for :ticket_types,
                                allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :staffs,
                                allow_destroy: true,
                                reject_if: :invalid_staff_info

  has_many :bookings
  has_many :user_tickets, through: :bookings
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
  validates :ticket_types, presence: true

  # scope
  scope :recent_events, -> { order(created_at: :DESC).limit(12) }
  scope :featured_events, -> { order(created_at: :DESC).limit(12) }

  def expiration_date_cannot_be_in_the_past
    today = Time.zone.today
    if end_date.present? && (end_date < today || end_date < start_date)
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
    find_by_sql(scope_raw_query(PopularQuery.build))
  end

  def self.search(search_params)
    query = SearchQuery.build_by(search_params)
    find_by_sql(scope_raw_query(query))
  end

  def self.upcoming_events
    time = Time.zone.now
    where("start_date >= ?", time).limit(12).order("start_date ASC")
  end

  def self.scope_raw_query(query)
    tenant = ActsAsTenant.current_tenant
    query = query.where(arel_table[:manager_profile_id].eq(tenant.id)) if tenant
    query.to_sql
  end

  def ticket_sold
  end

  private

  def invalid_staff_info(attr)
    attr["role"].blank? || attr["user_id"].blank?
  end
end
