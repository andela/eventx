require "rails_helper"

RSpec.describe Subscription, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :event }
    it { is_expected.to belong_to :manager_profile }
    it { is_expected.to belong_to :user }
  end
end
