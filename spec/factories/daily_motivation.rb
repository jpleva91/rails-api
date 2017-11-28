FactoryGirl.define do
  factory :daily_motivation do
    quote { Faker::Lorem.word }
    author { Faker::StarWars.character }
  end
end