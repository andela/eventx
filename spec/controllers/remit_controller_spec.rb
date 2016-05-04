require "rails_helper"

RSpec.describe RemitController, type: :controller do
  before do
    @create_manager = create(:manager_profile)
    @event = create(:event, manager_profile_id: @create_manager.id)
  end

  after(:all) do
    Event.destroy_all
    ManagerProfile.destroy_all
  end

  describe "#new" do
    it "gets new remit when remit is requested for" do
      @event.update(start_date: Time.now - 10.days)
      @event.update(end_date: Time.now - 9.days)

      get :new, id: @event.id

      expect(assigns(:remit).event.title).to eq "Blessings wedding"
      expect(
        assigns(:remit
               ).event.description
      ).to eq "Happy day of joy celebration happinness smiles."
      expect(assigns(:remit).event.venue).to eq "Beside the waters"
    end

    it "does not get new remit when remit is requested for" do
      @event.update(start_date: Time.now - 10.days)
      @event.update(end_date: Time.now - 3.days)

      get :new, id: @event.id

      expect(flash[:notice]).to eq "Event cannot yet request a remittance!"
    end
  end
end
