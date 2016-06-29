require "rails_helper"

RSpec.feature "RequestRefund", type: :feature, js: true do
  before(:each) do
    @user = create(:user, email: "user@eventx.com")
    @event = create(:event, :cancelled)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@user)
  end

  scenario "when user visits tickets page" do
    create(:booking, event: @event, user: @user, payment_status: 2, amount: 20)
    visit tickets_path
    expect(page).to have_content "REQUEST REFUND"
    expect(page).to have_content "Cancelled"
  end

  scenario "when event is cancelled and paid" do
    create(:booking, event: @event, user: @user, payment_status: 2, amount: 20)
    visit tickets_path
    click_link "request-refund"
    expect(page).to have_content "The event was cancelled"
    expect(page).to have_content "SUBMIT REQUEST"
    within("#refund-form") do
      find("a", text: "SUBMIT REQUEST").click
    end

    expect(page).to have_content "PROCESSING REQUEST"
  end

  scenario "when event is cancelled and free" do
    create(:booking, event: @event, user: @user)
    visit tickets_path
    expect(page).not_to have_content "REQUEST REFUND"
  end
end
