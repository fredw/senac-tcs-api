class ReservoirGroup < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
end
