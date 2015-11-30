require "barby"
require "barby/barcode"
require "barby/barcode/qr_code"
require "barby/outputter/png_outputter"

module PrintHelper
  def print_ticket(ticket_type_id, quantity)
    @ticket_type = TicketType.find(ticket_type_id)
    @event = @ticket_type.event
    tickets = ""
    quantity.times  { tickets += render "ticket" }
    tickets
  end

  def create_qr_code(event_title, user)
    msg = "Event title: #{event_title}; User: #{user}"
    qr = Barby::QrCode.new( msg, :size => 4, :level => :q )
    base64_output = Base64.encode64(qr.to_png({ xdim: 5 }))
    "data:image/png;base64,#{base64_output}"
  end

end
