FactoryGirl.define do
  factory :ruler do
    height { Faker::Number.decimal(2, 2) }
    association(:device)
  end
end