class Notification::Notifier
  attr_accessor :subscribers

  def self.notify_subscribers(event)
    setup
    find_subscribers(event)
    @subscribers.each do |subscriber|
      SendNotificationEmailJob.set(wait: 5.seconds).perform_later(subscriber, event)
    end
  end

  private
    def self.setup
      @categories = Category.all
    end

    def self.find_subscribers(event)
      @subscribers = event.category.subscribers
    end
end