module Admin::ApplicationHelper
  def image_uploadify
    session_key_name = Rails.application.config.session_options[:key]
    %Q{
    <script type='text/javascript'>
      $(document).ready(function() {
        $('#image_upload').uploadify({
          script          : '#{admin_product_images_path(@product)}',
          fileDataName    : 'image[image]',
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

  def uploadify_js
    content_for :script do
      concat javascript_include_tag("/uploadify/jquery.uploadify.v2.1.4.min.js")
      concat javascript_include_tag("/uploadify/swfobject.js")
      concat image_uploadify
    end
  end
end

