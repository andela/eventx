FactoryGirl.define do
  factory :manager_profile do
    subdomain "ladyb"
    company_name "Manogoa"
    company_mail "ema@a.com"
    company_phone "08062201524"
    domain "MyDomain"
    user
  end

  factory :regular_manager_profile, parent: :manager_profile do
    subdomain { Faker::Lorem.word }
    company_name { Faker::Company.name }
    company_mail { Faker::Internet.email }
    company_phone { Faker::PhoneNumber.phone_number }
    domain { Faker::Internet.url }
    user
  end
end
