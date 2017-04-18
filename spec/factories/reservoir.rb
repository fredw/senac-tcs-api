FactoryGirl.define do
  factory :reservoir do
    name { Faker::Name.name }
    description { Faker::Lorem.words(10) }
    volume { Faker::Number.decimal(2, 2)}
    customer { Customer.first || association(:customer) }
    association(:reservoir_group)
  end
end