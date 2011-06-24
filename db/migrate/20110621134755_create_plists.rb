class CreatePlists < ActiveRecord::Migration
  def change
    create_table :plists do |t|
      t.string :name
    end
  end
end

