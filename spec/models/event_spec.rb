require "rails_helper"

RSpec.describe Event, type: :model do
  it "should have a valid factory" do
    event = build(:event)
    expect(event).to be_valid
  end

  describe "#get_roles" do
    it "returns event roles" do
      result = { "Event Staff" => "event_staff",
                 "Event Manager" => "event_manager",
                 "Super Admin" => "super_admin" }
      expect(Event.get_roles).to eq result
    end
  end

  describe "#find_event" do
    it "finds event without parameters" do
      desc = "Happy day of joy celebration happinness smiles."
      create(:event)
      expect(Event.find_event({}).as_json.first["description"]).to eq desc
    end

    it "finds event with parameters" do
      create(:event)
      desc = "Happy day of joy celebration happinness smiles."
      params = { event_name: "Blessings wedding" }
      expect(Event.find_event(params).as_json.first["description"]).to eq desc
    end
  end
end
