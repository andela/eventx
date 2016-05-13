require "rails_helper"

RSpec.describe Eventsponsor, type: :model do
  subject { create(:event_sponsor) }

  describe "sponsor validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :logo }
    it { is_expected.to validate_presence_of :url }
    it { is_expected.to validate_presence_of :summary }
  end
end
