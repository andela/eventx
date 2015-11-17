require "faker"

module Fakeout
  class Builder

    FAKEABLE = %w(Event)

    attr_accessor :report

    def initialize
      self.report = Reporter.new
      clean!
    end

    # create products (can be free)
    def events(count = 1, options = {})
      1.upto(count) do
        attributes   = { :title        => Faker::Commerce.product_name,
                         :description => Faker::Lorem.paragraph(2),
                         :location => Faker::Address.city,
                         :start_date => Faker::Time.between(DateTime.now - 5, DateTime.now),
                         :end_date => Faker::Time.between(DateTime.now, DateTime.now + 5),
                         :image => Faker::Avatar.image,
                         :venue => Faker::Address.street_address,
                         :category => pick_random(Category),
                         :event_manager => pick_random(User),
                         :event_template => pick_random(EventTemplate)
                          }.merge(options)
        event      = Event.new(attributes)
        event.save!
      end
      self.report.increment(:events, count)
    end

    # cleans all faked data away
    def clean!
      FAKEABLE.map(&:constantize).map(&:destroy_all)
    end


    private

    def pick_random(model)
      ids = ActiveRecord::Base.connection.select_all("SELECT id FROM #{model.to_s.tableize}")
      model.find(ids[rand(ids.length)]["id"].to_i) if ids
    end

    def random_unique_email
      Faker::Internet.email.gsub("@", "+#{User.count}@")
    end
  end


  class Reporter < Hash
    def initialize
      super(0)
    end

    def increment(fakeable, number = 1)
      self[fakeable.to_sym] ||= 0
      self[fakeable.to_sym] += number
    end

    def to_s
      report = ""
      each do |fakeable, count|
        report << "#{fakeable.to_s.classify.pluralize} (#{count})\n" if count > 0
      end
      report
    end
  end
end
