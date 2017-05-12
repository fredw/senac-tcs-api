class RulerDataSerializer < ActiveModel::Serializer
  attributes :id, :created_at
  belongs_to :ruler
  has_many :level_sensor_data
end
