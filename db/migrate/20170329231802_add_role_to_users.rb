class AddRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role_id, :uuid
    add_foreign_key :users, :roles
  end
end
