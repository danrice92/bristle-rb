FactoryBot.define do
  factory :employment do
    title { Faker::Job.title }
    start_date { 1.year.ago.to_date }
    end_date { 1.day.ago.to_date }
    starting_pay { 12.to_d }
    ending_pay { 15.to_d }

    user
    employer
    user_career
  end
end
