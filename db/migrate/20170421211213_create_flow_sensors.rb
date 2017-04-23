class CreateFlowSensors < ActiveRecord::Migration[5.1]
  def change
    create_table :flow_sensors, id: :uuid do |t|
      t.string :pin
      t.timestamps
    end
    add_column :flow_sensors, :device_id, :uuid
    add_foreign_key :flow_sensors, :devices
  end
end
