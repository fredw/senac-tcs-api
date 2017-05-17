class ReservoirGroupSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :customer
  has_many :reservoirs

  link :self do
    href reservoir_group_path(object)
  end
end
