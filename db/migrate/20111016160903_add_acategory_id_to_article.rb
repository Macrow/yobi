class AddAcategoryIdToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :acategory_id, :integer
    add_index :articles, :acategory_id
    create_table :acategories do |t|
      t.string :name      
      t.timestamps
    end
    add_foreign_key(:articles, :acategories, :dependent => :delete)
  end

  def self.down
    remove_foreign_key(:articles, :acategories, :dependent => :delete)
    drop_table :acategories
    remove_index :articles, :acategory_id
    remove_column :articles, :acategory_id
  end
end
