module StaffRole
  extend ActiveSupport::Concern

  included do
    enum role: [:event_staff, :gate_keeper, :event_manager, :super_admin]
  end

  def staff_role_specifications
    {
      0 => "be an event staff",
      1 => "be a gate keeper",
      2 => "collaborate as an event manager",
      3 => "be a super admin"
    }
  end
end