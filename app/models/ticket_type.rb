class TicketType < ActiveRecord::Base
  belongs_to :event
  has_many :user_tickets

  def sold
    user_tickets.size
  end

  def total_amount_sold
    sold * price.to_f
  end

  def tickets_left
    quantity - sold
  end
end
