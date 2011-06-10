class AddDetailToProduct < ActiveRecord::Migration
  def change
    add_column :products, :retail_price, :decimal, :precision => 8, :scale => 2
    add_column :products, :present_price, :decimal, :precision => 8, :scale => 2
    add_column :products, :stock_count, :integer
  end
end

