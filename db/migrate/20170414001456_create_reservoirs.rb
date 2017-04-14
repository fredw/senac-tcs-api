class CreateReservoirs < ActiveRecord::Migration[5.1]
  def change
    create_table :reservoirs, id: :uuid do |t|
      t.string :name
      t.string :description
      t.float :volume
      t.references :customer, foreign_key: true
      t.references :reservoir_group, foreign_key: true, null: true

      t.timestamps
    end
  end
end
