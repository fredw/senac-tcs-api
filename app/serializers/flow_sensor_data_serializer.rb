class FlowSensorDataSerializer < ActiveModel::Serializer
  attributes :id, :consumption_per_minute, :flow_sensor

  link :self do
    href flow_sensor_data_path(object)
  end
end
