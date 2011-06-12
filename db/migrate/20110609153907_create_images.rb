class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image
      t.integer :product_id
      t.string :content_type
      t.integer :file_size
      t.boolean :is_major, :default => false

      t.timestamps
    end

    add_foreign_key(:products, :images, :dependent => :delete)
  end
end

