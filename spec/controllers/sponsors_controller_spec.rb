require "rails_helper"

RSpec.describe SponsorsController, type: :controller do
  describe "Event Manager" do
    before(:all) do
      @event_sponsor = create(:sponsor)
    end

    before(:each) do
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(
          @event_sponsor.event.manager_profile.user
        )
    end

    describe "GET index" do
      context "when event has sponsors" do
        before do
          get :index, event_id: @event_sponsor.event.id
        end

        it "should assign eventsponsor" do
          expect(assigns[:sponsors].count).to eq 1
        end
      end
    end

    describe "POST create" do
      context "when creating a new event sponsor" do
        let(:valid_create_request) do
          xhr(
            :post,
            :create,
            event_id: @event_sponsor.event.id,
            sponsor: attributes_for(:sponsor)
          )
        end

        it "returns success flash message" do
          valid_create_request
          expect(flash[:success]).to eq create_successful_message("sponsor")
        end

        it "should increase event sponsors count by 1" do
          expect do
            valid_create_request
          end.to change(Sponsor, :count).by(1)
        end
      end

      context "when creating a new event sponsor with invalid data" do
        let(:invalid_create_request) do
          xhr(
            :post,
            :create,
            event_id: @event_sponsor.event.id,
            sponsor: attributes_for(:sponsor, name: nil)
          )
        end

        it "returns error flash message" do
          invalid_create_request
          expect(flash[:error]).to eq create_failure_message("sponsor")
        end

        it "should not increase event sponsors" do
          expect do
            invalid_create_request
          end.to change(Sponsor, :count).by(0)
        end
      end
    end

    describe "PUT update" do
      context "when updating an event sponsor with valid data" do
        let(:valid_update_request) do
          xhr(
            :put,
            :update,
            event_id: @event_sponsor.event.id,
            sponsor: attributes_for(:sponsor),
            id: @event_sponsor.id
          )
        end

        it "should set flash success message" do
          valid_update_request
          expect(flash[:success]).to eq update_successful_message("sponsor")
        end
      end

      context "when updating an event sponsor with invalid data" do
        let(:invalid_update_request) do
          xhr(
            :put,
            :update,
            event_id: @event_sponsor.event.id,
            sponsor: attributes_for(:sponsor, name: nil),
            id: @event_sponsor.id
          )
        end

        it "should set flash success message" do
          invalid_update_request
          expect(flash[:error]).to eq update_failure_message("sponsor")
        end
      end
    end

    describe "DELETE destroy" do
      it "should decrease event sponsors count" do
        expect do
          xhr(
            :delete,
            :destroy,
            event_id: @event_sponsor.event.id,
            id: @event_sponsor.id
          )
        end.to change(Sponsor, :count).by(-1)
      end
    end
  end

  describe "Unauthorised User" do
    before(:all) do
      @user = create(:user)
      @event = create(:regular_event)
    end

    before(:each) do
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(@user)
    end

    describe "POST create" do
      let(:valid_create_request) do
        xhr(
          :post,
          :create,
          event_id: @event.id,
          sponsor: attributes_for(:sponsor)
        )
      end

      it "should redirect user to homepage" do
        valid_create_request
        expect(response).to redirect_to "/"
      end

      it "should not increase sponsors count" do
        expect do
          valid_create_request
        end.to change(Sponsor, :count).by(0)
      end
    end
  end
end
