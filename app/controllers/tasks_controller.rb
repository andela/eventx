class TasksController < ApplicationController
  load_and_authorize_resource
  before_action :find_event, :all_tasks

  layout "admin"
  
  def index
    @tasks = @event.tasks
  end

  def show
    @my_task = Task.where(event_id: @event.id, user_id: current_user.id)
  end
  
  def new
    @task = @event.tasks.new
  end
  
  def create
    @task = @event.tasks.new(task_params)
    @task.assigner = current_user
    @task.event = @event
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
      flash[:success] = update_successful_message("task")
    else
      flash[:error] = update_failure_message("task")
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
    
    def find_task
      @task = @event.tasks.find(params[:id])
    end

    def all_tasks
      @tasks = @event.tasks
    end
    
    def task_params
      params.require(:task).permit(:name, :user_id, :completed_status)
    end
end
