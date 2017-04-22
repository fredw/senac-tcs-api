class Ruler < ApplicationRecord
  belongs_to :device
  validates :height, presence: true
  scope :from_customer, -> (customer) { joins(:device).joins(:reservoir).where(reservoirs: { customer: customer }) }
end
