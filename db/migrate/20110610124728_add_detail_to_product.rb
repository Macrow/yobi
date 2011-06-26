class AddDetailToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :retail_price, :decimal, :precision => 8, :scale => 2
    add_column :products, :present_price, :decimal, :precision => 8, :scale => 2
    add_column :products, :stock_count, :integer
    add_column :products, :stock_number, :string
    add_column :products, :elite, :boolean, :default => false
    add_column :products, :discount, :integer
    add_column :products, :quantity, :integer, :default => 0
  end

  def self.down
    remove_column :products, :retail_price
    remove_column :products, :present_price
    remove_column :products, :stock_count
    remove_column :products, :stock_number
    remove_column :products, :elite
    remove_column :products, :discount
    remove_column :products, :quantity
  end
end

