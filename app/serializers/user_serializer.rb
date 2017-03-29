class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at
  belongs_to :customer, serializer: CustomerSerializer
end
