class AddRulerDataToLevelSensorsData < ActiveRecord::Migration[5.1]
  def change
    add_column :level_sensors_data, :ruler_data_id, :uuid
    add_foreign_key :level_sensors_data, :rulers_data
  end
end
