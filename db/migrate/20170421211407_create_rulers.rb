class CreateRulers < ActiveRecord::Migration[5.1]
  def change
    create_table :rulers, id: :uuid do |t|
      t.decimal :height
      t.timestamps
    end
    add_column :rulers, :device_id, :uuid
    add_foreign_key :rulers, :devices
  end
end
