FactoryGirl.define do
  factory :reservoir_group do
    name { Faker::Name.name }
    customer { Customer.first || association(:customer) }
  end
end