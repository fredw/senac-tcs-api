class LevelSensorData < ApplicationRecord
  belongs_to :level_sensor

  scope :from_customer, -> (customer) { joins(level_sensor: [{ruler: [{device: :reservoir}]}]).where(reservoirs: { customer_id: customer.id }) }
end
