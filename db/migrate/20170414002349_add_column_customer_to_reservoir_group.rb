class AddColumnCustomerToReservoirGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :reservoir_groups, :customer_id, :uuid
    add_foreign_key :reservoir_groups, :customers
  end
end
