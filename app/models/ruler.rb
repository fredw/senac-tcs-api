class Ruler < ApplicationRecord
  belongs_to :device
  has_many :level_sensors, dependent: :destroy
  has_many :ruler_data, dependent: :destroy

  validates :height, presence: true

  scope :from_customer, -> (customer) { joins(device: :reservoir).where(reservoirs: { customer_id: customer.id }) }
  scope :from_device, -> (device) { where(device_id: device.id) }
end
