class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :active, :created_at
end
