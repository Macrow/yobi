#coding: utf-8
class Staticpage < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  before_save :verify_safe, :generate_meta_content, :generate_page_url
  default_scope order("created_at DESC")
  validates_presence_of :title
  validates_uniqueness_of :page_url
  
  private
  
  def verify_safe
    unless self.content.html_safe?
      self.content.gsub!(/<script.*?>.*?<\/script>/i, "")
    end
  end  

  def generate_meta_content
    if self.meta_keywords.blank?
      self.meta_keywords = "#{self.title},财务配套用品,财务软件"
    end
    if self.meta_description.blank?
      self.meta_description = truncate(self.content.gsub(/<(.*?)>/, ""), :length => 50)
    end
  end
  
  def generate_page_url
    if self.page_url.blank?
      self.page_url = self.title.to_url
    end
  end
end
