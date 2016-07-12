require File.expand_path("../boot", __FILE__)

require "rails/all"
require "wicked_pdf"

Bundler.require(*Rails.groups)

module EventX
  class Application < Rails::Application
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.autoload_paths += Dir["#{config.root}/lib/*"]
    config.active_job.queue_adapter = :sucker_punch
    config.assets.compile = true
    config.assets.digest = true
    config.active_record.raise_in_transactional_callbacks = true
    config.middleware.use WickedPdf::Middleware, {},
                          only: ["/print", "/download"]
  end
end
