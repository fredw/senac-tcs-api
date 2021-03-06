class Customer < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :reservoirs, dependent: :destroy
  has_many :reservoir_groups, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :active, inclusion: { in: [true, false] }
end
