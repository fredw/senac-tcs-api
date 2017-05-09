class DeviceSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :rulers
  belongs_to :reservoir
  has_many :flow_sensors, serializer: FlowSensorSerializer
  has_many :rulers, serializer: RulerSerializer

  link :self do
    href device_path(object)
  end
end
