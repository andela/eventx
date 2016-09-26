class TasksController < ApplicationController
  load_and_authorize_resource
  before_action :find_event

  layout "admin"
  
  def index
    @tasks = @event.tasks
  end
  
  def my_index
    @task = Task.my_tasks(@event, current_user)
  end

  def show
    @task = Task.my_tasks(@event, current_user)
  end
  
  def new
    @task = @event.tasks.new
  end
  
  def edit
    # @task = Task.find_by(params[:id, :event_id: @event.id])
  end
  
  def create
    @task = @event.tasks.new(task_params)
    if @task.save
      flash[:success] = create_successful_message("Task")
    else
      flash[:error] = create_failure_message("Task")
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = update_successful_message("Task")
    else
      flash[:error] = update_failure_message("Task")
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = delete_successful_message("task")
  end

  private

    def find_event
      @event = Event.find_by(id: params[:event_id])
    end
    
    def task_params
      params.require(:task).permit(:name, :user, :completed_status)
    end
end
