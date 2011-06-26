# coding: utf-8

module Admin::ApplicationHelper
  def uploadify_js(product)
    content_for :script do
      concat javascript_include_tag("/uploadify/jquery.uploadify.v2.1.4.min.js")
      concat javascript_include_tag("/uploadify/swfobject.js")
      concat image_uploadify(admin_product_images_path(product), "image")
    end
  end

  def uploadify_and_kindeditor_js
    content_for :script do
      concat javascript_include_tag("/uploadify/jquery.uploadify.v2.1.4.min.js")
      concat javascript_include_tag("/uploadify/swfobject.js")
      concat javascript_include_tag("admin/kindeditor/kindeditor-min.js")
      concat javascript_include_tag("admin/kindeditor/kindeditor-init.js")
      concat image_uploadify(admin_dimages_path, "dimage")
    end
  end

  def uploadify_and_kindeditor_and_nested_form_js
    content_for :script do
      concat javascript_include_tag("/uploadify/jquery.uploadify.v2.1.4.min.js")
      concat javascript_include_tag("/uploadify/swfobject.js")
      concat javascript_include_tag("admin/kindeditor/kindeditor-min.js")
      concat javascript_include_tag("admin/kindeditor/kindeditor-init.js")
      concat javascript_include_tag("admin/nested_form.js")
      concat javascript_include_tag("client_validation/rails.validations.js")
      concat image_uploadify(admin_dimages_path, "dimage")
    end
  end

  def include_lightbox_js
    content_for :script do
      concat javascript_include_tag("lightbox/jquery.lightbox.min.js")
    end
  end

  def admin_user_links
    output = ""
    if user_signed_in? && current_user.admin?
      output << link_to("Site", root_path, :target => "_blank")
      output << " | "
      output << "Welcome #{current_user.user_name}"
      output << " | "
      output << link_to("Logout", destroy_user_session_path)
    end
    output.html_safe
  end

  def tab_to(name, c_name, a_name = "index")
    url = url_for(:controller => "admin/#{c_name}", :action => a_name)
    if controller_name.downcase == c_name
      html_options = {:class => "current"}
    end
    link_to(name, url, html_options)
  end

  def yield_or_partial(message, yield_message)
    content_for?(message) ? yield_message : render("admin/#{controller_name}/#{message}")
  end

  def nested_categories(categories)
    categories.map do |category, sub_categories|
      render(category) + content_tag(:div, nested_categories(sub_categories), :class => "nested_categories")
    end.join.html_safe
  end

  def category_and_ancestors_path(category)
    output = ""
    category.ancestors.each do |c|
      output << link_to(c.name, admin_category_path(c)) << " > "
    end
    output << link_to(category.name, admin_category_path(category))
    output.html_safe
  end

  def toggle_image_major(product, image)
    %Q{
    $.ajax({
          url: '#{admin_product_image_path(product, image)}',
          type: 'PUT',
          data: this.name + '=' + this.checked,
          dataType: 'script'
        });
    }.gsub(/[\n ]+/, ' ').strip.html_safe
  end

  private

  def image_uploadify(path, model_name)
    session_key_name = Rails.application.config.session_options[:key]
    %Q{
    <script type='text/javascript'>
      $(document).ready(function() {
        $('#image_upload').uploadify({
          script          : '#{path}',
          fileDataName    : '#{model_name}[#{model_name}]',
          uploader        : '/uploadify/uploadify.swf',
          cancelImg       : '/uploadify/cancel.png',
          fileDesc        : 'Images',
          fileExt         : '*.png;*.jpg;*.gif',
          sizeLimit       : #{10.megabytes},
          queueSizeLimit  : 24,
          multi           : true,
          auto            : true,
          buttonText      : 'Upload Images',
          scriptData      : {
            '_http_accept': 'application/javascript',
            '#{session_key_name}' : encodeURIComponent('#{u(cookies[session_key_name])}'),
            'authenticity_token'  : encodeURIComponent('#{u(form_authenticity_token)}')
          },
          onComplete      : function(a, b, c, response){ eval(response) }
        });
      });
    </script>
    }.gsub(/[\n ]+/, ' ').strip.html_safe
  end
end

