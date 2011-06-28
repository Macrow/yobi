class ProductSweeper < ActionController::Caching::Sweeper
  observe Product, Comment, Image

  def after_create(record)
    expire_product_by_comment(record) if record.is_a?(Comment)
    expire_product_by_image(record) if record.is_a?(Image)
    if record.is_a?(Product)
      expire_related_product(record)
    end
  end

  def after_update(record)
    expire_product_by_comment(record) if record.is_a?(Comment)
    expire_product_by_image(record) if record.is_a?(Image)
    if record.is_a?(Product)
      expire_product(record)
      expire_related_product(record)
    end
  end

  def after_destroy(record)
    expire_product_by_comment(record) if record.is_a?(Comment)
    expire_product_by_image(record) if record.is_a?(Image)
    if record.is_a?(Product)
      expire_product(record)
      expire_related_product(record)
    end
  end

  private

  def expire_product_by_comment(comment)
    expire_product(comment.commentable) if comment.commentable.is_a?(Product)
  end

  def expire_product_by_image(image)
    expire_product(image.product)
  end

  def expire_product(product)
    expire_action(:controller => "/products", :action => "show", :id => product)
  end

  def expire_related_product(product)
    product.find_related_tags.all.each { |p| expire_product(p) }
  end
end

