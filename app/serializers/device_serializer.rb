class DeviceSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :reservoir

  link :self do
    href device_path(object)
  end
end
