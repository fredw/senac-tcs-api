class Reservoir < ApplicationRecord
  belongs_to :customer
  belongs_to :reservoir_group, optional: true

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 250 }
  validates :volume, presence: true
end
