class RemitMailer < ApplicationMailer
  def remitance_confirmation(event, manager, remit)
    @event = event
    @manager = manager

    @remit = remit
    mail(to: manager.company_mail, subject: "Remittance Ticket Fee")
  end
end
