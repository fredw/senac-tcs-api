class Device < ApplicationRecord
  belongs_to :reservoir

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 250 }

  scope :from_customer, -> (customer) { joins(:reservoir).where(reservoirs: { customer: customer }) }
end
