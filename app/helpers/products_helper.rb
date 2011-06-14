module ProductsHelper
  def product_major_image(product)
    if product.major_image.nil?
      link_to image_tag("/images/no-pic.png", :size => "150x150"), product
    else
      link_to image_tag(product.major_image.image.thumb.url, :size => "150x150"), product
    end
  end
end

