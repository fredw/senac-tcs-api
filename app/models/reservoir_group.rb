class ReservoirGroup < ApplicationRecord
  belongs_to :customer
  has_many :reservoirs, dependent: :nullify

  validates :name, presence: true, length: { maximum: 100 }
end
