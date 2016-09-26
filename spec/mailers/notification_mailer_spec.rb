require "rails_helper"

RSpec.describe EventMailer, type: :mailer do
  describe "New Event Notification" do
    before(:all) do
      @user = User.create(first_name: "Michael",
                          last_name: "Ogala",
                          email: "mykel41@gmail.com"
                          )
      @event = Event.create(title: "DefJam",
                            description: "A music event for music lovers",
                            location: "Lagos, Nigeria",
                            venue: "Westview Hotel",
                            category_id: 1)
      @cat = Category.create(name: "music",
                              description: "For music lovers and artists")
      @cat.events << @event
      @user.subscriptions << @event.category
      @user.subscriptions(true)
      @mail = NotificationsMailer.new_subscribed_event(@user, @event)
    end
    it "Displays the email" do
      expect(@mail.to).to eq [@user.email]
      expect(@mail.subject).to eq "New #{@event.category.name} event"
      expect(@mail).to have_content('Hi')
    end
  end
end
