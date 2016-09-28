require "rails_helper"

RSpec.describe TasksController, type: :controller do
  describe "Event Manager" do
    before(:all) do
      @event_task = create(:task)
    end

    before(:each) do
      allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(
          @event_task.event.manager_profile.user
        )
    end

    describe "GET index" do
      context "when event has tasks" do
        before do
          get :index, event_id: @event_task.event.id
        end

        it "should assign an event task" do
          expect(assigns[:tasks].count).to eq 1
        end
      end
    end

    describe "POST create" do
      context "when creating a new event task" do
        let(:valid_create_request) do
          xhr(
            :post,
            :create,
            event_id: @event_task.event.id,
            task: attributes_for(:task)
          )
        end

        it "returns success flash message" do
          valid_create_request
          expect(flash[:success]).to eq create_successful_message("task")
        end

        it "should increase event tasks count by 1" do
          expect do
            valid_create_request
          end.to change(Task, :count).by(1)
        end
      end

      context "when creating a new event task with invalid data" do
        let(:invalid_create_request) do
          xhr(
            :post,
            :create,
            event_id: @event_task.event.id,
            task: attributes_for(:task, name: nil)
          )
        end

        it "returns error flash message" do
          invalid_create_request
          expect(flash[:error]).to eq create_failure_message("task")
        end

        it "should not increase event tasks" do
          expect do
            invalid_create_request
          end.to change(Task, :count).by(0)
        end
      end
    end

    describe "PUT update" do
      context "when updating an event task with valid data" do
        let(:valid_update_request) do
          xhr(
            :put,
            :update,
            event_id: @event_task.event.id,
            task: attributes_for(:task),
            id: @event_task.id
          )
        end

        it "should set flash success message" do
          valid_update_request
          expect(flash[:success]).to eq update_successful_message("task")
        end
      end

      context "when updating an event task with invalid data" do
        let(:invalid_update_request) do
          xhr(
            :put,
            :update,
            event_id: @event_task.event.id,
            task: attributes_for(:task, name: nil),
            id: @event_task.id
          )
        end

        it "should set flash success message" do
          invalid_update_request
          expect(flash[:error]).to eq update_failure_message("task")
        end
      end
    end

    describe "DELETE destroy" do
      it "should decrease event tasks count" do
        expect do
          xhr(
            :delete,
            :destroy,
            event_id: @event_task.event.id,
            id: @event_task.id
          )
        end.to change(Task, :count).by(-1)
      end
    end
  end

  describe "Unauthorised User" do
    before(:all) do
      @user = create(:regular_user)
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
          task: attributes_for(:task)
        )
      end

      it "should redirect user to homepage" do
        valid_create_request
        expect(response).to redirect_to "/"
      end

      it "should not increase tasks count" do
        expect do
          valid_create_request
        end.to change(Task, :count).by(0)
      end
    end
  end
end
