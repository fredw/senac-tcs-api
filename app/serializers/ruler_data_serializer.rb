class RulerDataSerializer < ActiveModel::Serializer
  attributes :id, :ruler, :created_at
  has_many :level_sensor_data
end
