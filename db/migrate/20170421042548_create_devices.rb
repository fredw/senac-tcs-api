class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices, id: :uuid do |t|
      t.string :name
      t.string :description
      t.timestamps
    end
    add_column :devices, :reservoir_id, :uuid
    add_foreign_key :devices, :reservoirs
  end
end
