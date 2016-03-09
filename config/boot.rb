ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../../Gemfile", __FILE__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require 'rails/commands/server'
<<<<<<< HEAD
module Rails
  class Server
    def default_options
      super.merge(Host:  '0.0.0.0', Port: 3000)
    end
  end
end
=======

module Rails
  class Server
    def default_options
      super.merge(Host: '0.0.0.0', Port: 3000)
    end
  end
end
>>>>>>> 1cdd5821c4a321755d86964c4543128267904a4d
