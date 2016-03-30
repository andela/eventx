require "rails_helper"

describe "EventDecorator" do
  let(:raw_event) { FactoryGirl.build(:event) }
  let(:event) { FactoryGirl.build_stubbed(:event).decorate }

  context '#start_date' do
    it { expect(event.start_date).to be_a String }
    it do
      expect(event.start_date).
        to end_with(raw_event.start_date.strftime("%Y"))
    end
  end

  context '#event_template' do
    it { expect(event.event_template).to eql("blue") }
  end

  context '#end_date' do
    it { expect(event.end_date).to be_a String }
    it { expect(event.end_date).to end_with(raw_event.end_date.strftime("%Y")) }
  end

  context '#get_event_staffs' do
    it { expect(event.get_event_staffs).to be_a String }
  end

  context '#generator' do
    it { expect(event.generator).to be_an Icalendar::Event }
    it do
      expect(event.generator).to respond_to(:dtstart)
      expect(event.generator).to respond_to(:dtend)
      expect(event.generator).to respond_to(:uid)
      expect(event.generator).to respond_to(:summary)
      expect(event.generator).to respond_to(:description)
      expect(event.generator).to respond_to(:location)
      expect(event.generator).to respond_to(:uid)
    end
    it { expect(event.generator.uid).to start_with("http://test.host/events") }
  end

  context '#calendar' do
    it { expect(event.calendar).to be_an Icalendar::Calendar }
    it do
      calendar = spy("Icalendar::Calendar")
      allow(Icalendar::Calendar).to receive(:new) { calendar }
      event.calendar
      expect(calendar).to have_received(:add_event)
      expect(calendar).to have_received(:publish)
    end
  end

  context '#google_calender_link' do
    it do
      expect(event.google_calender_link).
        to include "https://www.google.com/calendar/render"
    end
  end
end
