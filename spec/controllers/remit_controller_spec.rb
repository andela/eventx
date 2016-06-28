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
    context "when event has ended" do
      it "gets new remit when remit is requested for" do
        @event.update(start_date: Time.now - 10.days)
        @event.update(end_date: Time.now - 9.days)

        get :new, id: @event.id

        expect(assigns(:remit).event.title).to eq "Blessings wedding"
        expect(assigns(:remit).event.venue).to eq "Beside the waters"
        expect(assigns(:remit).event.description).
          to eq "Happy day of joy celebration happinness smiles."
      end
    end

    context "when event has not ended" do
      it "does not get new remit when remit is requested for" do
        @event.update(start_date: Time.now - 10.days)
        @event.update(end_date: Time.now - 3.days)

        get :new, id: @event.id

        expect(flash[:notice]).to eq messages.remit_not_due
      end
    end

    context "when a remit has been requested" do
      it "does not allow remit to be requested twice" do
        @event.update(start_date: Time.now - 10.days)
        @event.update(end_date: Time.now - 9.days)

        remit = @event.build_remit
        remit.save

        get :new, id: @event.id
        expect(flash[:notice]).to eq messages.remit_duplicate_alert
        remit.destroy
      end
    end
  end
end
