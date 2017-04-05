class Customer < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
end
