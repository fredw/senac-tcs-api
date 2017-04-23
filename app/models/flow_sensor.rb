class FlowSensor < ApplicationRecord
  belongs_to :device

  validates :pin, presence: true, length: { is: 2 }, uniqueness: { scope: :device_id }

  scope :from_customer, -> (customer) do
    joins(device: :reservoir).where(reservoirs: { customer_id: customer.id })
  end
end
