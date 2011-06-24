class Property < ActiveRecord::Base
  belongs_to :product
  validates_presence_of :name, :value
end

