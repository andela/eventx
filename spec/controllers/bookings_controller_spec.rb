require "rails_helper"

RSpec.describe BookingsController, type: :controller do
  before do
    sign_in_omniauth
    create_booking
  end


  context "#index" do
    it "gets bookings if user has booked for an event" do
      get :index
      expect(assigns(:bookings).length).to eq 1
      expect(assigns(:bookings)[0].event.title).to eq "Blessings wedding"
    end

    it "does not get bookings if user has not booked for an event" do
      session[:user_id] = 22
      get :index
      expect(assigns(:bookings)).to be nil
    end
  end
end
