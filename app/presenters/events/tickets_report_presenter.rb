module Events
  class TicketsReportPresenter
    attr_reader :event

    def initialize(event)
      @event = event
    end

    def all_bookings
      event.bookings.paginate(page: 1, per_page: 20).decorate
    end

    def attendees
      event.attendees.paginate(page: 1, per_page: 20)
    end

    def ticket_types
      TicketReport.ticket_types(event)
    end

    def calculate_total(prop)
      ticket_types.map(&prop.to_sym).inject(0, &:+)
    end
  end
end
