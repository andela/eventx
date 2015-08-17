class Event < ActiveRecord::Base
  #association
  belongs_to :category
  belongs_to :event_template
  has_one :ticket, dependent: :destroy
  accepts_nested_attributes_for :ticket
  #has_many :attendees, class_name: 'User'

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


  #scope
  scope :recent_events, -> {order(created_at: :DESC).limit(12)}
  scope :featured_events, -> {order(created_at: :DESC).limit(2)}
  scope :popular_events, -> {order(created_at: :DESC).limit(3)}
  #scope :popular_events, -> {where('id > ?', 3).limit(3)}

end
