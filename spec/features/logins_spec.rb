require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  scenario "the user tries to login with facebook" do

    visit root_path

    expect(page).to have_selector("h1", text: "EventX")
    expect(page).to have_selector("", text: "EventX")
  end
  #pending "add some scenarios (or delete) #{__FILE__}"
end
