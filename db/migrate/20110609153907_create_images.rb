class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :image
      t.integer :product_id
      t.string :content_type
      t.integer :file_size
      t.boolean :is_major, :default => false

      t.timestamps
    end

    add_index :images, :product_id
    add_foreign_key(:products, :images, :dependent => :delete)
  end

  def self.down
    remove_foreign_key(:products, :images, :dependent => :delete)
    remove_index :images, :product_id
    drop_table :images
  end
end

