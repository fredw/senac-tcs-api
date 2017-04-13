class RoleSerializer < ActiveModel::Serializer
  attributes :id, :name, :symbol

  link :self do
    href role_path(object)
  end
end
