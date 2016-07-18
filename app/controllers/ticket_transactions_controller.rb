class TicketTransactionsController < ApplicationController
  before_action :authenticate_user
  before_action :set_ticketing, except: :index
  protect_from_forgery except: [:hook]

  def index
    @ticket_transactions = TicketTransaction.pending(params[:id]).decorate
  end

  def checkout_ticket
    transaction = TicketTransaction.find(params[:id])
    @transaction = transaction.decorate
    payers_email = @transaction.payers_email
    amount = @ticketing.ticket_amount(@transaction)

    if amount.to_i.eql?(0)
      @ticketing.approve_transfer(transaction_id: transaction.id,
                                  payer_email: payers_email)
      redirect_to bookings_path
    else
      pay_info = { transaction: @transaction,
                   amount: amount,
                   return_path: ticket_transaction_hook_path }

      redirect_to transaction.pay_pal_url(pay_info)
    end
  end

  def hook
    params.permit!
    response = validate_ipn_notification(request.raw_post)
    if response == "VERIFIED"
      if params[:payment_status] == "Completed"
        @ticketing.approve_transfer(transaction_id: params[:invoice],
                                    payer_email: params[:payer_email])

        redirect_to bookings_path
      end
    else
      flash[:notice] = "Invalid transaction ensure the" \
                       "receipient have a paypal account"

      redirect_to root_path
    end
  end

  def validate_ipn_notification(raw)
    uri = URI.parse(TicketTransaction.validate_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 60
    http.read_timeout = 60
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    http.post(uri.request_uri, raw,
              "Content-Length" => raw.size.to_s,
              "User-Agent" => "EventX"
             ).body
  end

  def create
    result = @ticketing.initiate_transfer(ticket_params)
    flash[:notice] = result[:message]

    render json: { location: ticket_transaction_path(result[:id]),
                   status: result[:status] }
  end

  def show
    @transaction = TicketTransaction.find(params[:id]).decorate
    if params[:delete]
      flash[:notice] = @ticketing.reject_transfer(@transaction.id)
      redirect_to root_path
    else
      @total_amount = @ticketing.total_ticket_amount(@transaction)
    end
  end

  def destroy
    flash[:notice] = @ticketing.reject_transfer(params[:id])

    redirect_to root_path
  end

  private

  def set_ticketing
    @ticketing ||= Ticketing.new
  end

  def ticket_params
    params.permit(:recipient, :booking_id, ticket_ids: [])
  end
end
