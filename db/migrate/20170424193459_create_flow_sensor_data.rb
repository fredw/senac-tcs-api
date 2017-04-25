class CreateFlowSensorData < ActiveRecord::Migration[5.1]
  def change
    create_table :flow_sensors_data, id: :uuid do |t|
      t.decimal :consumption_per_minute

      t.timestamps
    end
    add_column :flow_sensors_data, :flow_sensor_id, :uuid
    add_foreign_key :flow_sensors_data, :flow_sensors
  end
end
