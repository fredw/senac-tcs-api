FactoryGirl.define do
  factory :level_sensor do
    sequence(:pin, (0..9).cycle) { |n| ('A'..'Z').to_a.sample + n.to_s }
    volume { Faker::Number.decimal(2,2) }
    association(:ruler)
  end
end