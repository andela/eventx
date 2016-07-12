Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 60
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 5.minutes
Delayed::Worker.read_ahead = 10
Delayed::Worker.delay_jobs = !Rails.env.test?
Delayed::Worker.raise_signal_exceptions = :term


if Rails.env.development?
  module Delayed::Backend::Base
    def payload_object_with_reload
      if @payload_object_with_reload.nil?
        ActiveSupport::Dependencies.clear
      end
      @payload_object_with_reload ||= payload_object_without_reload
    end
    alias_method_chain :payload_object, :reload
  end
end
