require "barby"
require "barby/barcode"
require "barby/barcode/qr_code"
require "barby/outputter/png_outputter"

module PrintHelper
  def print_ticket(ticket)
    ticket_number = ticket.ticket_number
    type = TicketType.find(ticket.ticket_type_id).name
    render "printer/ticket", ticket_type: type, ticket: ticket
  end

  def create_qr_code(msg)
    qr = Barby::QrCode.new(msg, size: 4, level: :q)
    base64_output = Base64.encode64(qr.to_png(xdim: 5))
    "data:image/png;base64,#{base64_output}"
  end
end
