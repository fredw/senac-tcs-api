class FlowSensor < ApplicationRecord
  belongs_to :device
  validates :pin, presence: true, length: { is: 2 }
  scope :from_customer, -> (customer) { joins(:device).joins(:reservoir).where(reservoirs: { customer: customer }) }
end
