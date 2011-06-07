class AddForeignKeyToCategory < ActiveRecord::Migration
  def self.up
    add_foreign_key(:categories, :products, :dependent => :delete)
  end

  def self.down
    remove_foreign_key(:categories, :dependent => :delete)
  end
end

