class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
    sub = current_user.school
    sub = 'www' if sub.nil?
    "http://#{sub}.#{STUDYEGG_PATH}"
  end
  
  def after_sign_out_path_for(resource_name)
    "http://#{STUDYEGG_USER_MANAGER_PATH}"
  end
  
  def referrer
    request.env['HTTP_REFERER']
  end
#  def set_subdomain(sub)
#    @subdomain = sub
#    @subdomain = 'default' if sub.nil?
#    cookies[:sub] = @subdomain
#    puts "cookie set: #{@subdomain}"
#  end
end
