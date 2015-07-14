class User < ActiveRecord::Base
  # This set the roles of the users
  enum role: [:attendee, :event_staff, :event_manager, :super_admin ]
end
