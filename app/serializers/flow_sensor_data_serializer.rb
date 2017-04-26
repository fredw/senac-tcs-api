class FlowSensorDataSerializer < ActiveModel::Serializer
  attributes :id, :consumption_per_minute, :created_at
end
