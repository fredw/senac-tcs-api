FactoryGirl.define do
  factory :device do
    name { Faker::Name.name }
    description { Faker::Lorem.words(10) }
    association(:reservoir)
  end
end