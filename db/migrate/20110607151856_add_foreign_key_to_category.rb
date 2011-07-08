class AddForeignKeyToCategory < ActiveRecord::Migration
  def self.up
    add_foreign_key(:products, :categories, :dependent => :delete)
  end

  def self.down
    remove_foreign_key(:products, :categories, :dependent => :delete)
  end
end

