class CreatePlists < ActiveRecord::Migration
  def self.up
    create_table :plists do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :plists
  end
end

