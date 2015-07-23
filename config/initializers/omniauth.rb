OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'],
           :scope => 'email', :info_fields => 'name, email'

  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"]

  provider :twitter, ENV["TWITTER_API_KEY"], ENV["TWITTER_SECRET"], { image_size: 'bigger'}

  provider :linkedin, ENV["LINKEDIN_CONSUMER_KEY"], ENV["LINKEDIN_CONSUMER_SECRET"]

  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user"

  provider :instagram, ENV['INSTAGRAM_ID'], ENV['INSTAGRAM_SECRET']
end
