require 'rails_helper'

RSpec.feature "Inbox Messages", type: :feature, js: true do
  before(:each) do
    @message1 = create(:message)
    sign_up
  end

  scenario 'User is able to view all inbox messages' do
    message2 = create(:message, title: 'DefJam')
    visit dashboard_messages_path
    expect(page.current_path).to eq '/dashboard/messages'
    expect(page).to have_content(@message1.title)
    expect(page).to have_content(message2.title)
  end

  scenario 'User should be able to see how many new messages they have' do
    message2 = create(:message, title: 'DefJam')
    visit dashboard_messages_path
    expect(page).to have_content('Inbox2')
  end

  scenario 'User is able to read the contents of a message' do
    visit dashboard_messages_path
    find_link('WinSider Connect').trigger('click')
    expect(page).to have_content(@message1.title)
    expect(page).to have_content(@message1.body)
  end

  scenario 'User can delete a message' do
    visit dashboard_messages_path
    expect(page).to have_content(@message1.title)
    find('.fa-trash').trigger('click')
    expect(page).to_not have_content(@message1.title)
  end
end