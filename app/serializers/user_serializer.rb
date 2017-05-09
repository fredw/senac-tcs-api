class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :confirmed_at, :created_at, :updated_at, :role
  belongs_to :customer, serializer: CustomerSerializer
  belongs_to :role, serializer: RoleSerializer

  def role
    RoleSerializer.new(object.role)
  end

  link :self do
    href user_path(object)
  end
end
