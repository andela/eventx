ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
if Rails.env.production?
  abort("The Rails environment is running in production mode!")
end
# require "coveralls"
# Coveralls.wear!
require "spec_helper"
require "rspec/rails"
require "factory_girl"
require "capybara"
require "capybara/rspec"
require "capybara/rails"
require "database_cleaner"
require "capybara/poltergeist"
require "webmock/rspec"

WebMock.allow_net_connect!

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false, inspector: true,
                                         timeout: 60,
                                         phantomjs: Phantomjs.path)
end

Capybara.javascript_driver = :poltergeist

Capybara.server do |app, port|
  require "rack/handler/puma"
  Rack::Handler::Puma.run(app, Port: port)
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do |example|
    DatabaseCleaner.strategy =
      example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
    Rails.application.load_seed
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
  config.infer_spec_type_from_file_location!
  config.include ApplicationHelper
  config.include Requests::JsonHelper, type: :controller
  config.include Requests::ApiHelper, type: :controller
end

def sign_up
  set_valid_omniauth
  OmniAuth.config.test_mode = true
  visit root_path
  expect(page).to have_content "SIGN UP"
  click_link "Sign up"
  click_link "Google"
  visit root_path
end

def sign_in_omniauth
  set_valid_omniauth
  OmniAuth.config.test_mode = true
  request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  request.env["omniauth.auth"]
end

def user
  user = User.from_omniauth(request.env["omniauth.auth"])
  session[:user_id] = user.id
  user
end

def event
  # binding.pry
  manager = create(:manager_profile, user: user)
  event_template = EventTemplate.create(
    name: "purple",
    image: "http://goo.gl/erHIiU"
  )
  category = Category.create(
    name: "Networking", description:
    "Business mixers, hobby meetups, and panel discussions"
  )
  create(
    :event, manager_profile: manager,
            event_template: event_template,
            category: category
  )
end

def create_booking
  booking = create(:booking)
  @user = user
  @event = event
  booking.user_id = @user.id
  booking.event_id = @event.id
  booking.save
  ticket_type = create(:ticket_type, event: @event)
  create(:user_ticket, ticket_type: ticket_type, booking: booking)
end


