require "rails_helper"

describe ManagerProfile, type: :model do
  describe "associations" do
    it { is_expected.to have_many :subscriptions }
    it { is_expected.to have_many :subscribers }
  end
end
