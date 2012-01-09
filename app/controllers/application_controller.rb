class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
    "http://#{current_user.school}.#{STUDYEGG_PATH}"
  end
  
  def after_sign_out_path_for(resource_name)
    "http://#{STUDYEGG_USER_MANAGER_PATH}"
  end
  
  def set_subdomain(sub)
    @subdomain = sub
    @subdomain = 'default' if sub.nil?
    cookies[:sub] = @subdomain
  end
end
