class Message
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

  def error_occured
    "An error occurred"
  end

  def event_updated
    "Your Event was successfully updated"
  end

  def event_created
    "Your Event was successfully created."
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

  def event_staff_added
    "Successfully added Staff!"
  end

  def event_staff_deleted
    "Successfully deleted Staff!"
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

  def sponsor_create_success
    "Event sponsor added"
  end

  def sponsor_create_error
    "Unable to create event sponsor"
  end

  def sponsor_update_success
    "Event sponsor updated"
  end

  def sponsor_update_error
    "Unable to update event sponsor"
  end

  def sponsor_delete_success
    "Event sponsor deleted"
  end
end
