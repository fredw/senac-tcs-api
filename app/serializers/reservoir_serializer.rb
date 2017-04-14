class ReservoirSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :volume
  has_one :customer
  has_one :reservoir_group
end
