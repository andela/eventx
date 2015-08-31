require "rails_helper"
require 'pry'

RSpec.describe EventMailer, type: :mailer do
  describe "attendance_confirmation" do
    # let(event.title){"Hello"}
    before(:all) do
      @user = User.create(first_name: "Stephen Sunday", email: "stephen.sunday@andela.com")
      @event = Event.new
      @event.title = "Hello"
      @event.start_date = Date.today
      @event.description = "Whatsup"
      @event.location = "Lagos, Nigeria"
      @event.map_url = "https://maps.google.com/maps/place?q=Lagos,+Nigeria&ftid=0x103b8b2ae68280c1:0xdc9e87a367c3d9cb"
      @mail = EventMailer.attendance_confirmation(@user, @event)

    end

    it "renders the headers" do
      expect(@mail.subject).to eq("#{@event.title}")
      expect(@mail.to).to eq([@user.email])
      expect(@mail.from).to eq(['eventxapp@gmail.com'])
    end

    it "renders the body" do
      expect(@mail.body.encoded).to match("Hi #{@user.first_name}")
    end
  end

end
