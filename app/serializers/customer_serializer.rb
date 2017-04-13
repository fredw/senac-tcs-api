class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :active, :created_at, :updated_at

  link :self do
    href customer_path(object)
  end
end
