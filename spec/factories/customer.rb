FactoryGirl.define do
  factory :customer do
    name { Faker::Name.name }
    active true
  end
end