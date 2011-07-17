class Menu < ActiveRecord::Base
  default_scope order("menus.order")
  
  scope :public_menus, where(:is_hidden => false)
end
