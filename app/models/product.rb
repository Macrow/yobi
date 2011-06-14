class Product < ActiveRecord::Base
  belongs_to :category
  has_many :images, :dependent => :destroy
  has_one :major_image, :class_name => "Image", :conditions => ["is_major = ?", true]

  validates_presence_of :name
  validates_numericality_of :retail_price, :present_price, :stock_count, :greater_than_or_equal_to => 0

  before_save :verify_safe

  private

  def verify_safe
    unless self.description.html_safe?
      self.description.gsub!(/<script.*?>.*?<\/script>/i, "")
    end
  end
end

