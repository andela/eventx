require "rails_helper"

RSpec.describe Category, type: :model do
  before do
    DatabaseCleaner.clean
  end
  after do
    DatabaseCleaner.clean
  end
  describe "#create" do
    it "is invalid without a name" do
      expect(FactoryGirl.build(:category)).to be_valid
      expect(FactoryGirl.build(:invalid_category)).not_to be_valid
    end
  end
end
