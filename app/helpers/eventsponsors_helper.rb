module EventsponsorsHelper
  def group_by_level(events, level)
    level_sponsors = []
    events.each do |event|
      if event.level == level
        level_sponsors << event
      end
    end
    level_sponsors
  end

  def can_manage_sponsor(sponsor)
    can_manage = current_user ? current_user.event_manager? : false
    if can_manage
      render partial: "eventsponsors/manage_sponsor", locals: { sponsor: sponsor }
    end
  end

  def can_add_event_sponsor
    if current_user
      render partial: "eventsponsors/add_sponsor"
    end
  end
end
