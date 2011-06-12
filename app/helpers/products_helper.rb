module ProductsHelper
  def product_major_image(product)
    if (image = product.major_image).nil?
      image_tag "/images/no-pic.png", :size => "150x150"
    else
      image_tag image.thumb.url, :size => "150x150"
    end
  end
end

