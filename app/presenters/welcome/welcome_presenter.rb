module Welcome
  class WelcomePresenter
    def attendee_count
      Attendee.count
    end

    def ticket_count
      UserTicket.count
    end

    def event_count
      Event.count
    end
  end
end
