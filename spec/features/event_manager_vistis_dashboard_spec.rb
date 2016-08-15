require "rails_helper"

RSpec.feature "event manager visits dashboard", type: :feature, js: true do
  scenario "successfully" do
    sign_in

    visit dashboard_path

    expect(page).to have_css "h5", text: "Account Overview"
    expect(page).to have_css "h5", text: "My Events"
  end
end

def sign_in
  user = create(:user, email: "user@eventx.com")
  manager = create(:manager_profile, user: user, company_mail: "company@eventx.com", subdomain: "random")
  event = create(:event, :cancelled, manager_profile: manager)

  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
end
