module MessagesHelper
  def ticket_invalid
    "Ticket does not exist"
  end

  def duplicate_request
    "This request has already been granted"
  end

  def grant_refund_success
    "You have successfully granted a refund request"
  end

  def grant_refund_failure
    "Refund request cannot be granted at this time"
  end

  def ticket_used
    "Ticket has already been used"
  end

  def ticket_quantity_empty
    "You have to specify quantity of ticket required!"
  end

  def ticket_quantity_exeeded
    "Ticket quantity specified is above the available quantity."
  end

  def invalid_address
    "Invalid address!"
  end

  def invalid_subdomain
    "Subdomain does not exist"
  end

  def not_authenticated
    "You need to log in"
  end

  def event_unattended
    "You have successfully unattended this event"
  end

  def new_subscription(category)
    "You have successfully subscribe to notifications from #{category}"
  end

  def subcription_cancelled(category)
    "You have unsubscribed notifications from #{category} category"
  end

  def error_occured
    "An error occurred"
  end

  def message_deleted
    'Message has been deleted'
  end

  def update_successful_message(class_name = "record")
    "Your #{class_name} was successfully updated"
  end

  def create_successful_message(class_name = "record")
    "Your #{class_name} was successfully created"
  end

  def delete_successful_message(class_name = "record")
    "Your #{class_name} was successfully deleted"
  end

  def update_failure_message(class_name = "record")
    "Your #{class_name} was not updated"
  end

  def create_failure_message(class_name = "record")
    "Your #{class_name} was not created"
  end

  def delete_failure_message(class_name = "record")
    "Your #{class_name} was not deleted"
  end

  def no_popular_event
    "This category does not have a popular event"
  end

  def event_not_found
    "Event not found"
  end

  def manager_create_success
    "You can now create and manage events."
  end

  def form_submission_error
    "There is an error with the form submitted"
  end

  def booking_not_found
    "Booking not found"
  end

  def remit_not_due
    "Event cannot yet request a remittance!"
  end

  def remit_duplicate_alert
    "This event remit have already been processed"
  end

  def invalid_token
    "Invalid token or provider supplied"
  end

  def not_authorized
    "You are not authorized to access this page"
  end
end
