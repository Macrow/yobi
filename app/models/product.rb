class Product < ActiveRecord::Base
  belongs_to :category
  has_many :images, :dependent => :destroy
  validates_presence_of :name
end

