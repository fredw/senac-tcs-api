class RulerSerializer < ActiveModel::Serializer
  attributes :id, :height
  belongs_to :device
  has_many :level_sensors

  link :self do
    href ruler_path(object)
  end
end
