class AddCachedSlugToModels < ActiveRecord::Migration
  def self.up
    add_column :articles, :cached_slug, :string
    add_index  :articles, :cached_slug, :unique => true
    add_column :categories, :cached_slug, :string
    add_index  :categories, :cached_slug, :unique => true
    add_column :products, :cached_slug, :string
    add_index  :products, :cached_slug, :unique => true
  end

  def self.down
    remove_column :articles, :cached_slug
    remove_column :categories, :cached_slug
    remove_column :products, :cached_slug
  end
end

