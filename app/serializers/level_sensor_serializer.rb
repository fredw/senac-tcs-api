class LevelSensorSerializer < ActiveModel::Serializer
  attributes :id, :pin, :volume, :sequence, :ruler

  link :self do
    href level_sensor_path(object)
  end
end
