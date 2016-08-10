ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
if Rails.env.production?
  abort("The Rails environment is running in production mode!")
end
require "coveralls"
Coveralls.wear!
require "spec_helper"
require "rspec/rails"
require "factory_girl"
require "capybara"
require "capybara/rspec"
require "capybara/rails"
require "database_cleaner"
#require "capybara/poltergeist"
require "webmock/rspec"

WebMock.allow_net_connect!

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

# Capybara.register_driver :poltergeist do |app|
#   Capybara::Poltergeist::Driver.new(app, js_errors: false, inspector: true,
#                                          timeout: 60,
#                                          phantomjs: Phantomjs.path)
# end

#Capybara.javascript_driver = :poltergeist

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

  # Clean up all jobs specs with truncation
  config.before(:each, job: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  config.infer_spec_type_from_file_location!
  config.include ApplicationHelper
  config.include MessagesHelper
  config.include Requests::JsonHelper, type: :controller
  config.include Requests::ApiHelper, type: :controller
  config.include Requests::ApiHelper, type: :feature
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
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

def sign_up_and_create_an_event_manager
  sign_up
  find_link("Become An Event Manager").trigger("click")
  fill_in "manager_profile[company_name]", with: "Our Comapany"
  fill_in "manager_profile[company_mail]", with: "baba@yaho.com"
  fill_in "manager_profile[company_phone]", with: "08023439399"
  fill_in "manager_profile[subdomain]", with: "ladyb"
  click_button "Submit"
end
