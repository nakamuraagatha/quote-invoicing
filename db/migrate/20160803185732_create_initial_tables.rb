class CreateInitialTables < ActiveRecord::Migration
  def change

    create_table :items do |t|
      t.string :name
      t.text :description
      t.text :image
      t.decimal :price, :precision => 10, :scale => 2

      t.timestamps
    end

    create_table :quotes do |t|
      t.integer :user_id
      t.text :message

      t.timestamps
    end

    create_table :quote_items do |t|
      t.integer :quote_id
      t.integer :item_id
      t.integer :quantity
    end

    create_table :invoices do |t|
      t.integer :user_id
      t.integer :quote_id
      t.string :name
      t.text :description
      t.decimal :total, :precision => 10, :scale => 2

      t.timestamps
    end

    create_table :invoice_items do |t|
      t.integer :item_id
      t.integer :invoice_id
      t.boolean :custom, :default => false
      t.string :name
    end

    create_table :invoice_payments do |t|
      t.integer :invoice_id
      t.timestamps
    end




  end
end
