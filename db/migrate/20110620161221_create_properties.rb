class CreateProperties < ActiveRecord::Migration
  def self.up
    create_table :properties do |t|
      t.string :name
      t.string :value
      t.integer :product_id

      t.timestamps
    end

    add_index :properties, :product_id
    add_foreign_key(:products, :properties, :dependent => :delete)
  end

  def self.down
    remove_foreign_key(:products, :properties, :dependent => :delete)
    drop_table :properties
  end
end

