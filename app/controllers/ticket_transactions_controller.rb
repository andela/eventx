class TicketTransactionsController < ApplicationController
  before_action :authenticate_user
  before_action :set_ticketing, except: :index

  def index
    @ticket_transactions = TicketTransaction.pending(params[:id]).decorate
  end

  def set_ticketing
    @ticketing ||= Ticketing.new
  end

  def create
    result = @ticketing.ticket_transaction(ticket_params)
    flash[:notice] = result[:message]

    render json: { location: ticket_transaction_path(result[:id]),
                   status: result[:status] }
  end

  def show
    @transaction = TicketTransaction.find(params[:id]).decorate
    if params[:delete]
      flash[:notice] = @ticketing.reject_ticket_transaction(@transaction.id)
      
     redirect_to root_path 
    else
      @total_amount = @ticketing.total_ticket_amount(@transaction)
    end
  end

  def destroy
    flash[:notice] = @ticketing.reject_ticket_transaction(params[:id])

    redirect_to root_path
  end

  private

  def ticket_params
    params.permit(:recipient, :booking_id, ticket_ids: [])
  end
end
