class CreateStaticPages < ActiveRecord::Migration
  def self.up
    create_table :staticpages do |t|
      t.string :title
      t.string :page_url
      t.text :content
      t.string :meta_keywords
      t.string :meta_description

      t.timestamps
    end
  end

  def self.down
    drop_table :staticpages
  end
end
