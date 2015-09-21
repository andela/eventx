class RenameTicketTypesIdToTicketTypeIdInUserTickets < ActiveRecord::Migration
  def change
    rename_column :user_tickets, :ticket_types_id, :ticket_type_id
  end
end
