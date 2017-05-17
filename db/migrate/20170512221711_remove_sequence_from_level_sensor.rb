class RemoveSequenceFromLevelSensor < ActiveRecord::Migration[5.1]
  def change
    remove_column :level_sensors, :sequence, :string
  end
end
