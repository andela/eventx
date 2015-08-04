class AddEventTemplateIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_template_id, :integer
  end
end
