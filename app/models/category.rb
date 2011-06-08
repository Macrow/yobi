class Category < ActiveRecord::Base
  has_ancestry
  has_many :products, :dependent => :destroy
  validates_presence_of :name
end

