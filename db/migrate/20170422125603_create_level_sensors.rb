class CreateLevelSensors < ActiveRecord::Migration[5.1]
  def change
    create_table :level_sensors, id: :uuid do |t|
      t.string :pin
      t.timestamps
    end
    add_column :level_sensors, :ruler_id, :uuid
    add_foreign_key :level_sensors, :rulers
  end
end
