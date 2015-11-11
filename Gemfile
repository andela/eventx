source "https://rubygems.org"
ruby "2.2.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "4.2.1"
gem "acts_as_tenant"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.1.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem "therubyracer", platforms: :ruby
gem "cancancan"
# Use jquery as the JavaScript library
gem "jquery-rails"
gem "materialize-sass"
gem "font-awesome-sass"
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem "turbolinks"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.0"
# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "~> 0.4.0", group: :doc
gem "redcarpet"
gem "draper"
# Use ActiveModel has_secure_password
# gem "bcrypt", "~> 3.1.7"
gem "rspec-rails"
gem "capybara"
gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "omniauth-twitter"
gem "omniauth-linkedin"
gem "omniauth-github"
gem "omniauth-tumblr"
gem "figaro"
gem "responders"
gem "launchy"
gem "social-share-button", "~> 0.1.6"
gem "activerecord-import"

# for uploading pictures
gem "carrierwave"

# requires the imagemagick >=6.4 application
gem "rmagick"
gem "cloudinary"

# Use Unicorn as the app server
# gem "unicorn"

# Use Capistrano for deployment
# gem "capistrano-rails", group: :development
gem "delayed_job_active_record"
gem "daemons"

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem "sqlite3"
  gem "pry-rails"
  gem "selenium-webdriver"
  # gem "capybara-webkit"
  gem "chromedriver-helper"
  gem "database_cleaner"
  gem "faker"
  gem "simplecov", :require => false
  gem "codeclimate-test-reporter", require: nil

  #This is used to perform asynchronous jobs like sending mails now or at a later time

  # gem "capybara-webkit"
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug"

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
end

group :production do
  gem "faker"
  gem "pg",             "0.17.1"
  gem "rails_12factor", "0.0.2"
end
