require "rails_helper"

RSpec.describe TasksController, type: :controller do
  describe "Authorised User" do
    before do
      @user = User.from_omniauth(set_valid_omniauth)
      session[:user_id] = @user.id

      @event = create(:regular_event)
      @event_task = create(:task, user: @user, event: @event)
      create(:event_staff, user: @user, event: @event, role: 2)
    end

    describe "GET index" do
      before do
        get :index, event_id: @event.id
      end

      it "is successful" do
        expect(controller).to respond_with :ok
      end

      it "renders the index" do
        expect(response).to render_template :index
      end

      it "should list event's tasks" do
        expect(assigns[:tasks].count).to eq 1
      end

      it "should only load the user's tasks into @my_tasks" do
        task1 = create(:task, event: @event)

        expect(assigns(:tasks)).to include(task1)
        expect(assigns(:my_tasks)).not_to include(task1)
      end
    end

    describe "POST create" do
      context "when creating a new event task" do
        let(:valid_request) do
          xhr(
            :post,
            :create,
            event_id: @event.id,
            task: build(:task, event: @event).attributes
          )
        end

        it "returns success flash message" do
          valid_request
          expect(flash[:success]).to eq create_successful_message("Task")
        end

        it "should increase event tasks" do
          expect { valid_request }.to change(@event.tasks, :count).by(1)
        end
      end

      context "when creating a new event task with invalid data" do
        let(:invalid_request) do
          xhr(
            :post,
            :create,
            event_id: @event.id,
            task: build(:task, name: nil).attributes
          )
        end

        it "returns error flash message" do
          invalid_request
          expect(flash[:error]).to eq create_failure_message("Task")
        end

        it "should not increase event tasks" do
          expect { invalid_request }.to change(@event.tasks, :count).by(0)
        end
      end
    end

    describe "PUT update" do
      context "when updating an event task with valid data" do
        let(:valid_update_request) do
          xhr(
            :put,
            :update,
            event_id: @event.id,
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
            event_id: @event.id,
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
            event_id: @event.id,
            id: @event_task.id
          )
        end.to change(Task, :count).by(-1)
      end
    end
  end

  describe "Unauthorised User" do
    describe "GET index" do
      it "should redirect user to homepage" do
        event_task = create(:task)
        get :index, event_id: event_task.event.id

        expect(flash[:notice]).
          to eq "You are not authorized to access this page."
        expect(response).to redirect_to root_path
      end
    end
  end
end
