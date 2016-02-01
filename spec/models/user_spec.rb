require "rails_helper"

RSpec.describe User, type: :model do
  before(:each) do
    DatabaseCleaner.clean_with(:truncation)
  end

  describe "#from_omniauth" do
    it "creates users from valid OmniAuth response" do
      expect(User.from_omniauth(set_valid_omniauth)).to be_instance_of User
      expect(User.from_omniauth(set_valid_omniauth)).not_to be nil
    end

    it "does not create users for invalid OmniAuth response" do
      expect(User.from_omniauth(set_invalid_omniauth)).
        not_to be_instance_of User
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


  describe "#lookup_email" do
    it "returns user email and id if the user exist" do
      user = FactoryGirl.create(:user)
      result = [{ "value" => "eb@gmaill.com", "data" => 1 }]
      expect(User.lookup_email(user.email)).to eq result
    end
  end

  describe "#user_info" do
    it "returns user information" do
      FactoryGirl.create(:user)
      parameter = { user_id: 1, role: "event_manager" }
      pic = "http://graph.facebook.com/1065771400114300/picture"
      result = { user_id: 1, role: "event_manager", first_name: "Blessing",
                 email: "eb@gmaill.com",
                 profile_url: pic,
                 user_role: "Event Manager" }
      expect(User.user_info(parameter)).to eq result
    end
  end

  describe "#user_hash" do
    it "returns a hash of user information" do
      FactoryGirl.create(:user)
      pic = "http://graph.facebook.com/1065771400114300/picture"
      parameter = { user_id: 1, role: "event_manager" }
      result = { first_name: "Blessing", email: "eb@gmaill.com",
                 profile_url: pic }
      expect(User.user_hash(parameter)).to eq result
    end
  end

  describe "#user_role" do
    it "returns user role" do
      expect(User.user_role("event_manager")).to eq "Event Manager"
    end
  end
end
