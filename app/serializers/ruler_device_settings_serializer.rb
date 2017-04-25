class RulerDeviceSettingsSerializer < ActiveModel::Serializer
  attributes :id
  has_many :level_sensors, serializer: LevelSensorDeviceSettingsSerializer
end
