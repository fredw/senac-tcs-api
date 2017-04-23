FactoryGirl.define do
  factory :level_sensor do
    sequence(:pin, (0..9).cycle) { |n| ('A'..'Z').to_a.shuffle[0] + n.to_s }
    volume { Faker::Number.decimal(2,2) }
    sequence(:sequence) { |n| n }
    association(:ruler)
  end
end