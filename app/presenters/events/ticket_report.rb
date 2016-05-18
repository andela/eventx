module Events
  class TicketReport
    attr_reader :ticket

    def initialize(ticket)
      @ticket = ticket
    end

    def self.ticket_types(event)
      event.ticket_types.map { |ticket| TicketReport.new ticket }
    end

    def name
      ticket.name
    end

    def quantity
      ticket.quantity.to_i
    end

    def tickets_sold
      ticket.user_tickets.count.to_i
    end

    def price
      ticket.price.to_f
    end

    def remains
      quantity - tickets_sold
    end

    def amount
      price * tickets_sold
    end
  end
end
