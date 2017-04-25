class DeviceSettingsSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :flow_sensors, serializer: FlowSensorDeviceSettingsSerializer
  has_many :rulers, serializer: RulerDeviceSettingsSerializer
end
