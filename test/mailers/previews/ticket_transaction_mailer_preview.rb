# Preview all emails at http://localhost:3000/rails/mailers/ticket_transaction_mailer
class TicketTransactionMailerPreview < ActionMailer::Preview
  def transfer_mail 
    TicketTransactionMailer.transfer_mail(options)
  end 
end
