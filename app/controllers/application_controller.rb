class ApplicationController < ActionController::Base
  protect_from_forgery
  
  @subdomain='default'
  
  def after_sign_in_path_for(resource)
    sub = current_user.school
    sub = 'www' if sub.nil?
    "http://#{sub}.#{STUDYEGG_PATH}"
  end
  
  def after_sign_out_path_for(resource_name)
    "http://#{STUDYEGG_USER_MANAGER_PATH}"
  end
  
  def _authenticate_user
    if !current_user
      begin
        puts "params[:redirect_uri] = #{params[:redirect_uri]}"
        referrer = (params[:redirect_uri].nil?) ? '' : params[:redirect_uri]
        puts "REFERRER! #{referrer.to_s}"
        domain = referrer.to_s.split(/.com/)
        puts domain[0]
        if domain[0][-9..-1]=='zendolabs'
          sub = domain[0].gsub!(/http:\/\//, '')
          puts sub
          subdomain = sub.split('.')
          puts subdomain[0]
          sub = (subdomain[0] == 'www') ? '' : subdomain[0]
          puts sub
        else
          puts "ELSE"
          sub = ''
        end

        redirect_to "#{STUDYEGG_USER_MANAGER_PATH}/#{sub}"
      
      rescue
        redirect_to "#{STUDYEGG_USER_MANAGER_PATH}"
      end
    end
  end 
end
