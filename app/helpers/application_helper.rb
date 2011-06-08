module ApplicationHelper
  def user_links
    output = ""
    if user_signed_in?
      output << "Welcome #{current_user.user_name}"
      output << " | "
      output << link_to("Logout", destroy_user_session_path)
      if current_user.admin?
        output << " | "
        output << link_to("Manage", admin_root_path)
      end
    else
      output << link_to("Login", new_user_session_path)
      output << " | "
      output << link_to("Register", new_user_registration_path)
    end
    output.html_safe
  end
end

