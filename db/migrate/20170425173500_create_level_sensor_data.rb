class CreateLevelSensorData < ActiveRecord::Migration[5.1]
  def change
    create_table :level_sensors_data, id: :uuid do |t|
      t.boolean :switched_on
      t.timestamps
    end
    add_column :level_sensors_data, :level_sensor_id, :uuid
    add_foreign_key :level_sensors_data, :level_sensors
  end
end
