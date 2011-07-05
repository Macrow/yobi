class AddMetaToModel < ActiveRecord::Migration
  def self.up
    add_column :categories, :meta_keywords, :string
    add_column :categories, :meta_description, :string
    add_column :products, :meta_keywords, :string
    add_column :products, :meta_description, :string
    add_column :articles, :meta_keywords, :string
    add_column :articles, :meta_description, :string
    
  end

  def self.down
    remove_column :categories, :meta_keywords
    remove_column :categories, :meta_description
    remove_column :products, :meta_keywords
    remove_column :products, :meta_description
    remove_column :articles, :meta_keywords
    remove_column :articles, :meta_description
  end
end
