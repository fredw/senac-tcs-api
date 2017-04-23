FactoryGirl.define do
  factory :flow_sensor do
    sequence(:pin, (0..9).cycle) { |n| ('A'..'Z').to_a.shuffle[0] + n.to_s }
    association(:device)
  end
end