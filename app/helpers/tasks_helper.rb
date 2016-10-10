module TasksHelper
  def can_manage_task(task)
    if true
      render(
        partial: "tasks/manage_task",
        locals: { task: task }
      )
    end
  end

  def can_add_event_task
    # binding.pry
    if can? :create, Task
      render partial: "tasks/add_task"
    end
  end

  def all_tasks
    # @event.tasks
  end

  def get_name_and_role(staff)
    first_name = User.find(staff.user_id).first_name
    last_name = User.find(staff.user_id).last_name
    last_name ||= ""
    role = staff.role.humanize.titleize
    first_name + " " + last_name + " (" + role + ")"
  end
end
