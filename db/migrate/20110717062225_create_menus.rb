class CreateMenus < ActiveRecord::Migration
  def self.up
    create_table :menus do |t|
      t.string :name
      t.string :url
      t.integer :order, :default => 0
      t.boolean :is_new_window, :default => false
      t.boolean :is_elite, :default => false
      t.boolean :is_new, :default => false
      t.boolean :is_hidden, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :menus
  end
end
