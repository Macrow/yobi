class CreateDimages < ActiveRecord::Migration
  def change
    create_table :dimages do |t|
      t.string :dimage
      t.string :content_type
      t.integer :file_size

      t.timestamps
    end
  end
end

