class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role_slug, :string, :default => 'customer'
  end
end
