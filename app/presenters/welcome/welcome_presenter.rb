module Welcome
  class WelcomePresenter
    def user_count
      User.count
    end

    def ticket_count
      UserTicket.count
    end

    def event_count
      Event.count
    end
  end
end
