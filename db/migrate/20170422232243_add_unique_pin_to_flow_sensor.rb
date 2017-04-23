class AddUniquePinToFlowSensor < ActiveRecord::Migration[5.1]
  def change
    add_index :flow_sensors, [:pin, :device_id], unique: true
  end
end
