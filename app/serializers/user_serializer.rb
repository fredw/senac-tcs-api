class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :confirmed_at, :created_at, :updated_at
  belongs_to :customer, serializer: CustomerSerializer
  belongs_to :role, serializer: RoleSerializer

  link :self do
    href user_path(object)
  end
end
