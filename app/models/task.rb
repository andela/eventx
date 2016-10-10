class Task < ActiveRecord::Base
  belongs_to :event
  belongs_to :user, class_name: "User"
  belongs_to :assigner, class_name: "User"

  validates :name, :user, :assigner, presence: true

  def self.my_tasks(user_id, event_id)
    Task.where(params(user_id: user_id, event_id: event_id))
  end
end
