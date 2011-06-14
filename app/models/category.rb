class Category < ActiveRecord::Base
  has_ancestry
  has_many :products, :dependent => :destroy
  validates_presence_of :name

  def self.get_categories_tree(include_root = false, root_text = "顶层目录")
    @categories = ancestry_options(Category.scoped.arrange(:order => 'created_at')) {|i| "#{'—' * i.depth} #{i.name}"}
    @categories.insert(0, [root_text, ""]) if include_root
    return @categories
  end

  private

  def self.ancestry_options(items)
    result = []
    items.map do |item, sub_items|
      result << [yield(item), item.id]
      result += ancestry_options(sub_items) {|i| "#{'└—‪' * i.depth} #{i.name}"}
    end
    result
  end
end

