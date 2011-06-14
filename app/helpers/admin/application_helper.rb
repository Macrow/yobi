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

  def tab_to(name, all_options = nil)
    url = all_options.is_a?(Array) ? all_options[0].merge({:only_path => false}) : "#"
    current_url = url_for(:action => controller.action_name, :only_path => false)
    html_options = {}
    if all_options.is_a?(Array)
      all_options.each do |o|
        if url_for(o.merge({:only_path => false})) == current_url
          html_options = {:class => "current"}
          break
        end
      end
    end
    link_to(name, url, html_options)
  end

  def yield_or_partial(message, yield_message)
    content_for?(message) ? yield_message : render("admin/#{controller_name}/#{message}")
  end

  def category_path(category)
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

