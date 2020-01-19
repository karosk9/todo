FactoryBot.define do
  factory :task do
    user

    title { Faker::Movie.quote }
  end
end
