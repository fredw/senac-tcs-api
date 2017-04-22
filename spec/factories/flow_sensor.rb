FactoryGirl.define do
  factory :flow_sensor do
    pin { ('A'..'Z').to_a.shuffle[0] + Faker::Number.number(1) }
    association(:device)
  end
end