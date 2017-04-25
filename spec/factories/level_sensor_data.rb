FactoryGirl.define do
  factory :level_sensor_data do
    switched_on { Faker::Boolean.boolean }
    association(:level_sensor)
  end
end