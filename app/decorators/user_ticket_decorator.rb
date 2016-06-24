class UserTicketDecorator < Draper::Decorator
  delegate_all

  def status 
    (self.is_used)? 'INVALID': 'VALID'
  end 

  def name 
    self.ticket_type.name 
  end 
end
