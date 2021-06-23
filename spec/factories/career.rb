FactoryBot.define do
  factory :career do
    title { Faker::Job.field }
  end
end