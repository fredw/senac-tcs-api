class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at, :updated_at
  belongs_to :customer, serializer: CustomerSerializer
  belongs_to :role, serializer: RoleSerializer
end
