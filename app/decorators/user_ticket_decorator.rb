class UserTicketDecorator < Draper::Decorator
  delegate_all

  def scanned
    is_used ? "is used" : "not used"
  end

  def name
    ticket_type.name
    if !valid?
      status_label("red", "not_interested", "Used")
    else
      status_label("teal", "verified_user", "Valid")
    end
  end

  def status
    if !valid?
      status_label("red", "not_interested", "Used")
    else
      status_label("teal", "verified_user", "Valid")
    end
  end

  def scan_ticket_button
    if valid?
      h.link_to "Scan", h.scan_path(ticket_no: ticket_number),
                class: "btn", id: "scan-ticket-button", remote: true
    end
  end

  def valid?
    !booking.granted && !is_used
  end

  def status_label(color, icon, text)
    "<span class='card-panel #{color}' \
    style='position: absolute; bottom: 8px; color: white'>
    <i class='material-icons'>#{icon}</i> #{text}</span>".html_safe
  end
end
