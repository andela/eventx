require "rails_helper"
require "support/booking_helper"

RSpec.describe TicketTransactionsController, type: :controller do
  include BookingHelper
  before(:each) do
    sign_in_omniauth
    create_booking
  end

  describe "GET index" do
    it "gets list of all pending transactions" do
      get :index, id: 1

      expect(assigns(:ticket_transactions).length).to eq 1
    end
  end

  describe "GET checkout_ticket" do
    context "when the total ticket amount is 0" do
      it "redirects to booking path" do
        get :checkout_ticket, id: 1

        expect(response).to redirect_to bookings_path
      end
    end

    context "when the total_amount ticket amount is above 0" do
      it "redirects to pay url" do
        create_paid_booking

        get :checkout_ticket, id: 2

        expect(response).to_not redirect_to bookings_path
      end
    end
  end

  describe "GET show" do
    context "with a delete parameter" do
      it "deletes the ticket transaction" do
        get :show, id: 1, delete: true

        expect(response).to redirect_to root_path
      end
    end

    context "without a delete parameter" do
      it "redirects to show ticket transaction path" do
        get :show, id: 1

        expect(assigns(:transaction)).to_not be_nil
      end
    end
  end

  describe "DELETE destroy" do
    it "cancels the ticket transaction" do
      delete :destroy, id: 1

      expect(response).to redirect_to root_path
    end
  end
end
