class ReservoirGroupSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :customer

  link :self do
    href reservoir_group_path(object)
  end
end
