require 'rails_helper'

RSpec.describe NotificationSubscription, type: :model do
  context 'Validations' do
    it { should have_db_column :user_id }
    it { should have_db_column :category_id }
    it { should have_db_column :inbox_notification }
    it { should have_db_column :email_notification }
    it { should have_db_index [:user_id, :category_id] }
  end

  context 'Associations' do
    it { should belong_to :subscriber }
    it { should belong_to :category }
  end
end
