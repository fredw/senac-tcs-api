class Role < ApplicationRecord
  enum symbols: [:admin, :user]
  has_many :users
end
