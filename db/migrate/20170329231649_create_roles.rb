class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles, id: :uuid do |t|
      t.integer :symbol
      t.string :name

      t.timestamps
    end
  end
end
