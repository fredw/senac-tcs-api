FactoryGirl.define do
  factory :flow_sensor do
    sequence(:pin, (0..9).cycle) { |n| ('A'..'Z').to_a.sample + n.to_s }
    association(:device)
  end
end