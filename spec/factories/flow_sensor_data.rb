FactoryGirl.define do
  factory :flow_sensor_data do
    consumption_per_minute { Faker::Number.decimal(2,2) }
    association(:flow_sensor)
  end
end