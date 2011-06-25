class CreateDimages < ActiveRecord::Migration
  def self.up
    create_table :dimages do |t|
      t.string :dimage
      t.string :content_type
      t.integer :file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :dimages
  end
end

