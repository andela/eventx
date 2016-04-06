class BookingDecorator < Draper::Decorator
  delegate_all

  def get_tickets
    user_tickets.select(:ticket_type_id).group(:ticket_type_id).count
  end

  def show_ticket_types
    ticket_types = ""
    get_tickets.each do |type_id, quantity|
      name = get_ticket_name(type_id)
      ticket_types << get_ticket_display(name, type_id, quantity)
    end
    ticket_types.html_safe
  end

  def get_ticket_name(ticket_type_id)
    TicketType.find_by(id: ticket_type_id).name
  end

  def get_ticket_display(type, type_id, quantity)
    link = h.print_path(id, type_id)
    h.content_tag(:option, type + ": #{quantity}", value: type_id)
  end
end
