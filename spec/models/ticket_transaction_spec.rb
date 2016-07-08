require "rails_helper"

RSpec.describe TicketTransaction, type: :model do
  let(:pay_pal_host_url) { "#{ENV['paypal_host']}/cgi-bin/webscr?" }

  before(:each) do
    @booking = create(:booking, user: create(:user), event: create(:event))
    @transaction = create(:ticket_transaction, booking: @booking)
  end

  it { should belong_to(:booking) }

  describe ".pending" do
    it "it returns list of pending transactions" do
      transaction = TicketTransaction.pending(@booking.id).first

      expect(transaction.accepted).to eq false
    end
  end

  describe '#pay_pal_url' do
    context "given payment info" do
      it "it returns the pay pal url for the transaction as a query string" do
        pay_info = { transaction: @transaction.decorate,
                     amount: 500,
                     return_path: "/" }
        pay_pal_url = @transaction.pay_pal_url(pay_info)

        expect(pay_pal_url).to eq "/cgi-bin/webscr?amount=500&business=eb%" \
                                  "40gmaill.com&cmd=_xclick&invoice=1" \
                                  "&item_name=Ticket%28s%29+for+the+Blessings+"\
                                  "wedding+event&item_number=1"\
                                  "&notify_url=%2Fticket_transaction_hook"\
                                  "&quantity=1&return=%2F"
      end
    end
  end

  describe ".validate_url" do
    it "it returns a valid paypal url" do
      valid_url = TicketTransaction.validate_url

      expect(valid_url).to eq pay_pal_host_url + "cmd=_notify-validate"
    end
  end
end
