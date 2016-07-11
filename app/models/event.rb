class Event < ActiveRecord::Base
  belongs_to :category
  belongs_to :event_template
  has_one :remit
  has_many :ticket_types, dependent: :destroy
  has_many :event_staffs, dependent: :destroy
  has_many :highlights, dependent: :destroy
  has_many :staffs, through: :event_staffs, source: "user"
  accepts_nested_attributes_for :ticket_types,
                                allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :event_staffs,
                                allow_destroy: true,
                                reject_if: :invalid_staff_info
  accepts_nested_attributes_for :highlights,
                                allow_destroy: true, reject_if: :all_blank
  has_many :bookings
  has_many :user_tickets, through: :bookings
  has_many :attendees, through: :bookings, source: "user"
  has_many :sponsors, dependent: :destroy
  has_many :reviews, dependent: :destroy

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
  scope :recent_events, lambda {
    where(enabled: true).
      order(created_at: :DESC).limit(12)
  }
  scope :popular_events_category, lambda { |category_id|
    where(category_id: category_id)
  }
  scope :featured_events, lambda {
    where(enabled: true).
      order(created_at: :DESC).limit(12)
  }

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

  def self.search_query(search_params)
    SearchQuery.build_by(search_params)
  end

  def self.search(search_params)
    query = scope_raw_query(search_query(search_params))
    find_by_sql(query)
  end

  def self.upcoming_events
    time = Time.zone.now
    where("start_date >= ?", time).limit(12).order("start_date ASC").
      where(enabled: true)
  end

  def self.scope_raw_query(query)
    tenant = ActsAsTenant.current_tenant
    query = query.where(arel_table[:manager_profile_id].eq(tenant.id)) if tenant
    query.to_sql
  end

  def self.my_event_search(search_params, manager_profile_id)
    search_params[:enabled] = false
    query = search_query(search_params).
            where(arel_table[:manager_profile_id].eq(manager_profile_id))
    find_by_sql(query.to_sql)
  end

  def self.get_roles
    roles = {}
    EventStaff.roles.each do |key, _value|
      role_text = key.split("_").map(&:capitalize).join(" ")
      roles[role_text] = key
    end
    roles
  end

  def self.find_event(params)
    if params.empty?
      recent_events
    else
      params = params.symbolize_keys
      params[:enabled] = true
      search(params)
    end
  end

  def can_request_remit?
    Date.today >= (end_date + 5.days)
  end

  def self.popular_by_categories(id)
    popular_events.select do |category|
      category.
        category_id == id.to_i
    end
  end

  private

  def invalid_staff_info(attr)
    attr["user_id"].blank?
  end
end
