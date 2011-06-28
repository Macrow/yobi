class Article < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title
  before_save :verify_safe

  has_friendly_id :title, :use_slug => true, :strip_non_ascii => true, :max_length => 50

  def normalize_friendly_id(text)
    text.to_url
  end


  def short_title(max = 25)
    cut_string("UTF-8", title, 0, max)
  end

  private

  def verify_safe
    unless self.content.html_safe?
      self.content.gsub!(/<script.*?>.*?<\/script>/i, "")
    end
  end

  def cut_string(charset,src,start,length)
    require "iconv"
    @conv = Iconv.new("UTF-16", charset)
    @reverse_conv = Iconv.new(charset, "UTF-16")
    p_start = start.class == Fixnum && start >= 0
    p_length = length.class == Fixnum && length >= 0
    return "" unless src && p_start && p_length
    src_utf16 = @conv.iconv(src)
    cutted_src_utf_16 = src_utf16[2*start+2, 2*length]
    @reverse_conv.iconv(cutted_src_utf_16)
  end
end

