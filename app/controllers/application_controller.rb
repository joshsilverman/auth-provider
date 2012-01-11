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
  
  def authenticate_user!(resource=nil)
    if !current_user
      puts "direct ref: #{request.env['HTTP_REFERER']}"
      puts "params[:redirect_uri] = #{params[:redirect_uri]}"
      referrer = (request.env['HTTP_REFERER'].nil?) ? '' : request.env['HTTP_REFERER']
      puts "REFERRER! #{referrer}"
      url = URI.parse(referrer.to_s)
      ref = url.host
      ref.gsub!(/http:\/\//, '')
      if ref[-14..-1]=='zendolabs.com/'
        sub = ref[0..-16]
        puts sub
        sub = '' if sub == 'www'
      else
        puts "ELSE"
        sub = ''
      end

      redirect_to "#{STUDYEGG_USER_MANAGER_PATH}/#{sub}"
    end
  end 
#  def set_subdomain(sub)
#    @subdomain = sub
#    @subdomain = 'default' if sub.nil?
#    cookies[:sub] = @subdomain
#    puts "cookie set: #{@subdomain}"
#  end
end
