module Events
  class TicketsReportPresenter
    attr_reader :event 

    def initialize(event)
      @event = event
    end

    def all_bookings 
      event.bookings.paginate(page: 1, per_page: 20)
    end 

    def attendees 
      event.attendees.paginate(page: 1, per_page: 20)
    end 

    def ticket_types 
      Report::Ticket.ticket_types(event) 
    end 

    def calculate_total(prop)
      ticket_types.map(&prop.to_sym).inject(0, &:+)
    end

  end

  module Report 
    class Ticket
      attr_reader :ticket

      def initialize(ticket)
        @ticket = ticket
      end  

      def self.ticket_types(event) 
        event.ticket_types.map {|ticket| Ticket.new ticket }
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
end 
