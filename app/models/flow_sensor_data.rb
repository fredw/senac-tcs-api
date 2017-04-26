class FlowSensorData < ApplicationRecord
  belongs_to :flow_sensor

  validates :consumption_per_minute, presence: true

  scope :from_customer, -> (customer) { joins(flow_sensor: [{device: :reservoir}]).where(reservoirs: { customer_id: customer.id }) }
  scope :by_date, -> (from, to) { where('created_at >= ? AND created_at <= ?', from, to) }
end
