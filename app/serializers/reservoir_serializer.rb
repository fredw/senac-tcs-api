class ReservoirSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :volume
  has_one :customer
  belongs_to :reservoir_group

  link :self do
    href reservoir_path(object)
  end
end
