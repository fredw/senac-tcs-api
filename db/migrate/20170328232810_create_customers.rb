class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers, id: :uuid do |t|
      t.string :name
      t.boolean :active
      t.timestamps
    end
    add_column :users, :customer_id, :uuid
    add_foreign_key :users, :customers
  end
end
