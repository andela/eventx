require "rails_helper"

RSpec.describe Review, type: :model do
  describe "review associations" do
    it { is_expected.to belong_to :event }
    it { is_expected.to belong_to :user }
  end
end
