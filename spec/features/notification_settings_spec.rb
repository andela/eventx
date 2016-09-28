require 'rails_helper'

RSpec.feature "Settings", type: :feature, js: true do

  scenario 'User subscribes to notifications from a category' do
    sign_up
    visit dashboard_settings_path
    expect(page.current_path).to eq '/dashboard/settings'
    expect(page).to have_content('ALL SUBSCRIPTIONS')
    expect(page).to have_content('NEW SUBSCRIPTION')

    find_link('New Subscription').trigger('click')
    expect(page).to have_content('Select A Category')

    find_button('Subscribe').trigger('click')
    expect(page).to have_content('Music')
    expect(page).to have_content('UNSUBSCRIBE')
  end

  scenario 'User unsubscribes to notifications from a category' do
    sign_up
    create(:notification_subscription, category_id: 3)
    visit dashboard_settings_path
    expect(page).to have_content('Your Subscriptions')
    expect(page).to have_content('Classes')
    click_link('Unsubscribe')
    expect(page).to_not have_content('Classes')
  end
end