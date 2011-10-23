#coding: utf-8
class Acategory < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :articles, :dependent => :nullify
  
  has_friendly_id :name, :use_slug => true, :strip_non_ascii => true, :max_length => 50

  def normalize_friendly_id(text)
    text.to_url
  end
end