class Notification::Notifier
  attr_accessor :subscribers

  def self.notify_subscribers(event)
    setup
    find_subscribers(event)
    @subscribers.each do |subscriber|
      #send notification
      puts  '******************************************************'
      puts "New Event #{event.title} has been created"
      puts  '******************************************************'
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