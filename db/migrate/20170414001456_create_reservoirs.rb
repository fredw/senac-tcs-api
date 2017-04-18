class CreateReservoirs < ActiveRecord::Migration[5.1]
  def change
    create_table :reservoirs, id: :uuid do |t|
      t.string :name
      t.string :description
      t.decimal :volume
      t.timestamps
    end
    add_column :reservoirs, :customer_id, :uuid
    add_column :reservoirs, :reservoir_group_id, :uuid, null: true
    add_foreign_key :reservoirs, :customers
    add_foreign_key :reservoirs, :reservoir_groups
  end
end
