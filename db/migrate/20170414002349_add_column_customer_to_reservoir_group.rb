class AddColumnCustomerToReservoirGroup < ActiveRecord::Migration[5.1]
  def change
    add_reference :reservoir_groups, :customer, foreign_key: true
  end
end
