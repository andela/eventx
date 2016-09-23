class Notification::Notifier
  attr_accessor :subscribers

  def self.notify_subscribers(event)
    setup
    find_subscribers(event)
    @subscribers.each do |subscriber|
      Message.create({
                      user_id: subscriber.id,
                      title: "New #{event.category.name} event '#{event.title}'",
                      body: message(subscriber, event),
                      sender: event.manager_profile.user.first_name
                    })
      SendNotificationEmailJob.set(wait: 20.seconds).perform_later(subscriber, event)
    end
  end

  private
    def self.setup
      @categories = Category.all
    end

    def self.find_subscribers(event)
      @subscribers = event.category.subscribers
    end

    def self.message(subscriber, event)
      "<h4>Hi, #{subscriber.first_name}</h4>"\
      "<p>A new #{event.category.name} event going to take place on #{event.start_date.strftime('%b %d %Y')}</p>"\
      "<h5>Event Details</h5>"\
      "<p>#{event.description}</p>"\
      "<p>#{event.location}</p>"\
      "<a href='/events/#{event.id}' class='btn waves-effect waves-light'>Attend This Event</a>"
    end

    def message_params(subscriber, event)
      {
        title: event.title,
        body: message(subscriber, event),
        sender: event.manager_profile.user.first_name
      }
    end
end