require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user, :manager) }
  before(:each) do
    allow(controller).to receive(:current_user).and_return(user)
    @category = attributes_for(:category)
  end

  describe "#index" do
    context "when category is created by current_user" do
      before(:each) do
        create(:category, manager_profile_id: user.manager_profile.id)
      end
      it "current user should have access" do
        expect(
          Category.last.manager_profile_id
        ).to eq user.manager_profile.id
      end
    end

    context "when category belongs to another user" do
      before(:each) do
        create(:category, manager_profile_id: 10)
      end
      it "current user should not have access" do
        expect(
          Category.last.manager_profile_id
        ).to_not eq user.manager_profile.id
      end
    end
  end

  describe "#create" do
    context "when a valid category is given" do
      it "creates a new category" do
        expect do
          post :create, category: @category, format: "js"
        end.to change(Category, :count).by(1)
      end

      it "returns a successful HTTP response" do
        expect(response.status).to eq 200
      end
    end
  end
end
