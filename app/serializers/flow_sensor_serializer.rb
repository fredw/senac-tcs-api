class FlowSensorSerializer < ActiveModel::Serializer
  attributes :id, :pin, :device

  link :self do
    href flow_sensor_path(object)
  end
end
