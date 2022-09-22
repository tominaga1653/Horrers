FactoryBot.define do
  factory :post do
    association :user
    total_rate { Faker::Number.between(from: 1, to: 5) }
    story_rate { Faker::Number.between(from: 1, to: 5) }
    fear_rate { Faker::Number.between(from: 1, to: 5) }
    splatter_rate { Faker::Number.between(from: 1, to: 5) }
    review { Faker::Lorem.characters(number: 30) }
    category { 0 }
    tmdb_no { 330 }
    is_spoiler { Faker::Boolean.boolean }
  end
end
