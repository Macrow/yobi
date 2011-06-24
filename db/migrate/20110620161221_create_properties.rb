class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.string :value
      t.integer :product_id

      t.timestamps
    end

    add_index :properties, :product_id
    add_foreign_key(:products, :properties, :dependent => :delete)
  end
end

