require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'Associations' do
    it { should belong_to :user }
  end

  context 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should validate_presence_of :sender }
    it { should have_db_column :user_id }
    it { should have_db_column :read }
  end

  context 'Scopes' do
    it 'should return only unread messages' do
      expect(Message.unread.where_values_hash).to eq({'read' => false})
    end
  end
end
