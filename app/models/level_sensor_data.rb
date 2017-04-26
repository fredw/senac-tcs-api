class LevelSensorData < ApplicationRecord
  belongs_to :level_sensor

  scope :from_customer, -> (customer) { joins(level_sensor: [{ruler: [{device: :reservoir}]}]).where(reservoirs: { customer_id: customer.id }) }
  scope :by_date, -> (from, to) { where('created_at >= ? AND created_at <= ?', from, to) }
  scope :switched_on, -> (value = true) { where(switched_on: value) }
end
