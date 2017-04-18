class Role < ApplicationRecord
  has_many :users

  enum symbols: [:admin, :user]

  validates :name, presence: true, length: { maximum: 50 }
  validates :symbol, presence: true
end
