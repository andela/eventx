require "rails_helper"

RSpec.feature "Grant Refund", type: :feature do
  before(:each) do
    @user = create(:user, email: "user@eventx.com")
    @manager = create(
      :manager_profile,
      user: @user,
      company_mail: "company@eventx.com",
      subdomain: "random"
    )
    @event = create(:event, :cancelled, manager_profile: @manager)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@user)
  end

  scenario "when user has requested refund" do
    create(
      :booking,
      event: @event,
      user: @user,
      payment_status: 2,
      amount: 20,
      refund_requested: true
    )
    create :user_ticket
    visit "/events/#{@event.id}/tickets-report"
    expect(page).to have_content "Grant Refund"
  end

  scenario "when manager grants refund" do
    create(
      :booking,
      event: @event,
      user: @user,
      payment_status: 2,
      amount: 20,
      refund_requested: true
    )
    create  :user_ticket
    create  :ticket_type
    visit "/events/#{@event.id}/tickets-report"
    click_link "Grant Refund"
    expect(page).to have_content "Refund Paid"
  end

  scenario "cannot download ticket when refund has been granted" do
    booking = create(
      :booking,
      event: @event,
      user: @user,
      payment_status: 2,
      amount: 20,
      refund_requested: true,
      granted: true
    )
    visit "/download/#{booking.id}"
    expect(page.current_path).to eq "/tickets"
  end

  scenario "cannot print ticket when refund has been granted" do
    booking = create(
      :booking,
      event: @event,
      user: @user,
      payment_status: 2,
      amount: 20,
      refund_requested: true,
      granted: true
    )
    visit "/print/#{booking.id}"
    expect(page.current_path).to eq "/tickets"
  end

  scenario "can see booking has been refunded when refund has been granted" do
    create(
      :booking,
      event: @event,
      user: @user,
      payment_status: 2,
      amount: 20,
      refund_requested: true,
      granted: true
    )
    visit "/tickets"
    expect(page).to have_content "Refund Paid"
    expect(page).not_to have_content "DOWNLOAD ALL TICKETS"
    expect(page).not_to have_content "Cancelled"
  end
end
