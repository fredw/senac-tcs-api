class LevelSensorDataSerializer < ActiveModel::Serializer
  attributes :id, :switched_on, :created_at
  belongs_to :level_sensor
  belongs_to :ruler_data
end
