class ReservoirGroup < ApplicationRecord
  belongs_to :customer
  has_many :reservoirs

  validates :name, presence: true, length: { maximum: 100 }
end
