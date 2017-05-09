class LevelSensorSerializer < ActiveModel::Serializer
  attributes :id, :pin, :volume, :sequence
  belongs_to :ruler

  link :self do
    href level_sensor_path(object)
  end
end
