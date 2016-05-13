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
    h.content_tag(:option, type + ": #{quantity}", value: type_id)
  end

  def request_refund_button
    generate_request_refund_button.html_safe if h.can? :request_refund, object
  end

  def generate_request_refund_button
    if refund_requested
      h.link_to "Processing Request", "#", class: "btn disabled"
    else
      h.link_to "Request Refund", h.refund_path(uniq_id),
                class: "btn", remote: true, method: :post, id: "request-refund"
    end
  end

  def status
    "<span class='card-panel red right' \
    style='position: relative; bottom: 37px; color: white'>
    Cancelled</span>".html_safe unless event.enabled
  end
end
