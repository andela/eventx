module SponsorsHelper
  def group_by_level(level)
    return [] unless @sponsors[level]
    @sponsors[level]
  end

  def can_manage_sponsor(sponsor)
    if event_manager?
      render(
        partial: "sponsors/manage_sponsor",
        locals: { sponsor: sponsor }
      )
    end
  end

  def show_level(sponsor_level, level)
    return "" unless @sponsors
    if @sponsors[level]
      sponsor_level
    else
      ""
    end
  end

  def add_sponsor
    if event_manager?
      "Add Sponsor"
    else
      "Become A Sponsor"
    end
  end

  def sponsor_level
    Sponsor.levels.keys
  end

  def event_manager?
    current_user ? current_user.event_manager? : false
  end

  def can_add_event_sponsor
    if current_user
      render partial: "sponsors/add_sponsor"
    end
  end
end
