class FlowSensor < ApplicationRecord
  belongs_to :device
  has_many :flow_sensors_data, dependent: :destroy

  validates :pin, presence: true, length: { maximum: 2 }, uniqueness: { scope: :device_id }

  scope :from_customer, -> (customer) { joins(device: :reservoir).where(reservoirs: { customer_id: customer.id }) }
  scope :from_device, -> (device) { where(device_id: device.id) }
end
