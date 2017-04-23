class RulerSerializer < ActiveModel::Serializer
  attributes :id, :height, :device

  link :self do
    href ruler_path(object)
  end
end
