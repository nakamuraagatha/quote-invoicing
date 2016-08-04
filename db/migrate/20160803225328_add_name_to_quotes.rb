class AddNameToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :name, :string
  end
end
