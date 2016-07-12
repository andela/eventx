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
    generate_request_refund_button if h.can? :request_refund, object
  end

  def generate_request_refund_button
    if refund_requested && !granted
      h.link_to "Processing Request", "#", class: "btn disabled print-box-size"
    elsif !refund_requested && !granted
      h.link_to "Request Refund", '#refund-form',
                class: "btn print-box-size refund-button modal-trigger",
                'data-id': uniq_id, 'data-event': event_id, id: "request-refund"
    end
  end

  def status
    if cancelled? && !granted
      "<span class='card-panel red right' \
      style='position: relative; bottom: 37px; color: white'>
      Cancelled</span>".html_safe
    elsif cancelled? && granted
      "<span class='card-panel blue right' \
      style='position: relative; bottom: 37px; color: white'>
      Refund Paid</span>".html_safe
    end
  end

  def cancelled?
    !event.enabled
  end

  def download_tickets_button
    generate_download_button unless refund_requested && granted
  end

  def generate_download_button
    h.link_to h.content_tag(:i, "", class: "fa fa-floppy-o") +
      " Download All Tickets", h.download_path(booking.id),
              class: "grey-text left", target: "_blank"
  end

  def status_or_grant
    return grant_refund_button if refund_requested && !granted
    return "Refund Paid" if refund_requested && granted
    payment_status.capitalize
  end

  def grant_refund_button
    h.link_to "Grant Refund", h.grant_refund_path(uniq_id), id: "grant-refund"
  end
end
