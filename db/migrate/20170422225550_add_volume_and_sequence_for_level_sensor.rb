class AddVolumeAndSequenceForLevelSensor < ActiveRecord::Migration[5.1]
  def change
    add_column :level_sensors, :volume, :decimal
    add_column :level_sensors, :sequence, :integer
    add_index :level_sensors, [:sequence, :ruler_id], unique: true
  end
end
