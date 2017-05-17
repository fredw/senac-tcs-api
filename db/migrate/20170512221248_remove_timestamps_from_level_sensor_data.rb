class RemoveTimestampsFromLevelSensorData < ActiveRecord::Migration[5.1]
  def change
    remove_column :level_sensors_data, :created_at, :string
    remove_column :level_sensors_data, :updated_at, :string
  end
end
