require "rails_helper"

RSpec.describe User, type: :model do
# let(:user){User.new}
  # before(:each) do
  #   @auth = set_valid_omniauth
  # end

  describe "#from_omniauth" do
    it "creates users from valid OmniAuth response" do
      expect(User.from_omniauth(set_valid_omniauth)).to be_instance_of User
      expect(User.from_omniauth(set_valid_omniauth)).not_to be nil
    end

    it "does not create users for invalid OmniAuth response" do
      expect(User.from_omniauth(set_invalid_omniauth)).not_to be_instance_of User
      expect(User.from_omniauth(set_invalid_omniauth)).to be false
    end
  end

  describe "#event_manager?" do
    it "returns true for users that are also event managers" do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:manager_profile, user: user)
      expect(user.event_manager?).to be_truthy
    end

    it "returns false for users that are not event managers" do
      person = User.from_omniauth(set_valid_omniauth)
      expect(person.event_manager?).to be_falsy
    end
  end

  describe "#generate_auth_token" do
    it "returns encoded string" do
      user = FactoryGirl.create(:user)
      expect(user.generate_auth_token).not_to be nil
    end
  end
end
