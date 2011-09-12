#coding: utf-8
class Product < ActiveRecord::Base
  belongs_to :category
  has_many :images, :dependent => :destroy
  has_one :major_image, :class_name => "Image", :conditions => ["is_major = ?", true]
  has_many :properties, :dependent => :destroy
  accepts_nested_attributes_for :properties, :allow_destroy => true
  validates_presence_of :name
  validates_numericality_of :retail_price, :present_price, :stock_count, :quantity, :greater_than_or_equal_to => 0
  before_save :verify_safe, :upate_discount, :generate_meta_content
  
  acts_as_commentable
  acts_as_taggable

  has_friendly_id :name, :use_slug => true, :strip_non_ascii => true, :max_length => 50

  def normalize_friendly_id(text)
    text.to_url
  end

  # include all subtree category
  scope :products_in_category, lambda {|id| where("category_id IN (SELECT categories.id FROM categories WHERE (categories.id = #{id} or ancestry like '#{id}/%' or categories.ancestry = '#{id}'))")}
  search_methods :products_in_category

  def tags_text
    self.tag_list.join(" ")
  end

  def tags_text=(text)
    self.tag_list = text.split(" ")
  end

  private

  def verify_safe
    unless self.description.html_safe?
      self.description.gsub!(/<script.*?>.*?<\/script>/i, "")
    end
  end

  def upate_discount
    if self.present_price > 0 and self.retail_price > 0
      self.discount = ((self.present_price/self.retail_price)*100).to_i
    else
      self.discount = 0
    end
  end

  def generate_meta_content
    if self.meta_keywords.blank?
      self.meta_keywords = "#{self.name},#{self.category.name},财务配套用品,财务软件"
    end
    if self.meta_description.blank?
      self.meta_description = "#{self.name},专业#{self.category.name}系列产品,友比最新价格为#{present_price}元,为您节省开支!"
    end
  end  
end

