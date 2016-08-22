module Welcome
  class WelcomePresenter
    def manager_count
      ManagerProfile.count
    end

    def ticket_count
      UserTicket.count
    end

    def event_count
      Event.count
    end
  end
end
