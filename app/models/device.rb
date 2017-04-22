class Device < ApplicationRecord
  belongs_to :reservoir
  has_many :flow_sensors, dependent: :destroy
  has_many :rulers, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 250 }

  scope :from_customer, -> (customer) { joins(:reservoir).where(reservoirs: { customer: customer }) }
end
