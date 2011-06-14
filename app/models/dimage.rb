class Dimage < ActiveRecord::Base
  mount_uploader :dimage, DimageUploader
  validates_presence_of :dimage
  before_save :update_dimage_attributes

  private
  def update_dimage_attributes
    self.content_type = dimage.file.content_type
    self.file_size = dimage.file.size
  end
end

