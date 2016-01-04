FactoryGirl.define do
  factory :manager_profile do
    user_id "1"
    subdomain "ladyb"
    company_name "Manogoa"
    company_mail "ema@a.com"
    company_phone "08062201524"
    domain "MyDomain"
    id 1
    factory :invalid_manager do
      id 2
      subdomain nil
    end
  end
end
