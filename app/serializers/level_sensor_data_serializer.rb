class LevelSensorDataSerializer < ActiveModel::Serializer
  attributes :id, :switched_on, :created_at
end
