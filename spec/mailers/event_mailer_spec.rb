require "rails_helper"
require "pry"

RSpec.describe EventMailer, type: :mailer do
  describe "attendance_confirmation" do
    # let(event.title){"Hello"}
    before(:all) do
      @user = User.create(first_name: "Stephen Sunday",
                          email: "stephen.sunday@andela.com")
      @event = Event.new
      @event.title = "Hello"
      @event.start_date = Date.today
      @event.description = "Whatsup"
      @event.location = "Lagos, Nigeria"
      @event.map_url = ""
      @mail = EventMailer.attendance_confirmation(@user, @event)
    end

    it "renders the headers" do
      expect(@mail.subject).to eq(@event.title.to_s)
      expect(@mail.to).to eq([@user.email])
      expect(@mail.from).to eq(["eventxapp@gmail.com"])
    end

    it "renders the body" do
      expect(@mail.body.encoded).to match("Hi #{@user.first_name}")
    end
  end

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
      @mail = EventMailer.new_subscribed_event(@user, @event)
    end
    it "Displays the email" do
      # open_email(@user.email)
      expect(@mail.to).to eq @user.email
      expect(@mail.subject).to eq "New #{event.title} event"
      expect(@mail).to have_content('Hi')
      # clear_emails
    end
  end
end
