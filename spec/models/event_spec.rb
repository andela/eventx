require "rails_helper"

RSpec.describe Event, type: :model do
  it "should have a valid factory" do
    event = FactoryGirl.build(:event)
    expect(event).to be_valid
  end
end
