class AddUniqueLevelSensorToLevelSensorData < ActiveRecord::Migration[5.1]
  def change
    add_index :level_sensors_data, [:ruler_data_id, :level_sensor_id], unique: true
  end
end
