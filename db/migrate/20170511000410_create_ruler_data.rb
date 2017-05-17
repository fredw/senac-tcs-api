class CreateRulerData < ActiveRecord::Migration[5.1]
  def change
    create_table :rulers_data, id: :uuid do |t|
      t.timestamps
    end
    add_column :rulers_data, :ruler_id, :uuid
    add_foreign_key :rulers_data, :rulers
  end
end
