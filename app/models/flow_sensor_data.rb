class FlowSensorData < ApplicationRecord
  belongs_to :flow_sensor

  validates :consumption_per_minute, presence: true

  scope :from_customer, lambda do |customer|
    joins(flow_sensor: [{device: :reservoir}]).where(reservoirs: { customer_id: customer.id })
  end
end
