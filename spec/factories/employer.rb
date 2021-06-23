FactoryBot.define do
  factory :employer do
    name { Faker::Company.name }
    industry { Faker::Job.field }
  end
end
