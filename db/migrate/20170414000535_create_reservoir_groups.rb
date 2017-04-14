class CreateReservoirGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :reservoir_groups, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
