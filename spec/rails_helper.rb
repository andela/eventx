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

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do |example|
    DatabaseCleaner.strategy =
      example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
  config.infer_spec_type_from_file_location!
  config.include ApplicationHelper
end
