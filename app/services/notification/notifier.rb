class Notification::Notifier
  attr_accessor :subscribers

  def self.notify_subscribers(event)
    setup
    find_subscribers(event)
    puts 'before sending mail'
    # EventMailer.new_subscribed_event(@subscribers.first, event).deliver_now
    # puts 'Email should have been sent'
    p '*' * 100
    @subscribers.each do |subscriber|
      puts "Event Mailer called next ****************************************"
      EventMailer.new_subscribed_event(subscriber, event).deliver_now
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