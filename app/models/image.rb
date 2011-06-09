class Image < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :product
  validates_presence_of :image
  before_save :update_image_attributes

  private
  def update_image_attributes
    self.content_type = image.file.content_type
    self.file_size = image.file.size
  end
end

