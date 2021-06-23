FactoryBot.define do
  factory :location do
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zipcode { Faker::Address.zip_code }
    country { Faker::Address.country }
  end
end
