require "rails_helper"

RSpec.describe ReviewsController, type: :controller do
  describe "POST create" do
    before(:all) do
      @attendee = create(:attendee)
      create(:booking, event_id: @attendee.event.id, user_id: @attendee.user.id)
    end

    before(:each) do
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(
          @attendee.user
        )
    end

    def create_review_request(body)
      post(
        :create,
        event_id: @attendee.event.id,
        review: attributes_for(
          :review,
          body: body,
          user_id: @attendee.user.id,
          event_id: @attendee.event.id
        ),
        format: :json
      )
    end

    context "when creating a review with valid details" do
      it "returns newly created review" do
        create_review_request("Great event")
        expect(JSON.parse(response.body)["body"]).to eq "Great event"
      end

      it "increases review count" do
        expect do
          create_review_request("Nice event")
        end.to change(Review, :count).by(1)
      end
    end

    context "when creating a review with invalid details" do
      it "returns an error message" do
        create_review_request(nil)
        expect(JSON.parse(response.body)["body"]).to include("can't be blank")
      end
    end
  end
end
