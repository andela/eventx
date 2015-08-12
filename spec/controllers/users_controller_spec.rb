require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before do
    DatabaseCleaner.strategy = :transaction
    OmniAuth.config.test_mode = true
  end

  context 'Valid User' do
    before do
      set_valid_omniauth
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
      # get signin_path('google_oauth2')
    end

    scenario "User signs in" do
      user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      expect(user).to be_valid
    end
  end
end
