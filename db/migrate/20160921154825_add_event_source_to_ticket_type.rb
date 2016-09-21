class AddEventSourceToTicketType < ActiveRecord::Migration
  def change
    add_column :ticket_types, :event_source, :string
  end
end
