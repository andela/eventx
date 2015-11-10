require "fakeout"

desc "Fakeout data"
task :fake => :environment do
  faker = Fakeout::Builder.new

  # fake users
  faker.events(20)

  # report
  puts "Faked!\n#{faker.report}"
end
