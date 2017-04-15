class ReservoirGroupSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :customer
end
