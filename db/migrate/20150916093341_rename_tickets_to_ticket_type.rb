class RenameTicketsToTicketType < ActiveRecord::Migration
  def change
    rename_table :tickets, :ticket_types
  end
end
