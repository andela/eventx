module EventsponsorsHelper
  def can_manage_sponsor(sponsor)
    if event_manager?
      render(
        partial: "eventsponsors/manage_sponsor",
        locals: { sponsor: sponsor }
      )
    end
  end

  def show_level(sponsor_level, level)
    return "" if @event_sponsors[level].nil?
    sponsor_level
  end

  def add_sponsor
    if event_manager?
      "Add Sponsor"
    else
      "Become A Sponsor"
    end
  end

  def sponsor_level
    Eventsponsor.levels.keys
  end

  def event_manager?
    current_user ? current_user.event_manager? : false
  end

  def can_add_event_sponsor
    if current_user
      render partial: "eventsponsors/add_sponsor"
    end
  end
end
