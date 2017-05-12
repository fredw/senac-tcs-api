class FlowSensorDataSerializer < ActiveModel::Serializer
  attributes :id, :consumption_per_minute, :created_at
  belongs_to :flow_sensor
end
