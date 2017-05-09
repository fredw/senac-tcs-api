class FlowSensorSerializer < ActiveModel::Serializer
  attributes :id, :pin
  belongs_to :device

  link :self do
    href flow_sensor_path(object)
  end
end
