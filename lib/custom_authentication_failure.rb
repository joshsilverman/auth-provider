class CustomAuthenticationFailure < Devise::FailureApp 

  protected 
  
  def redirect_url
    referrer = @@referrer
    puts "REFERRER! #{referrer}"
    puts params[:redirect_uri]
    ref = referrer.to_s
    ref.gsub!(/http:\/\//, '')
    if ref[-14..-1]=='zendolabs.com/'
      sub = ref[0..-16]
      puts sub
      sub = '' if sub == 'www'
    else
      puts "ELSE"
      sub = ''
    end
    
    #login_path
    "#{STUDYEGG_USER_MANAGER_PATH}/#{sub}"
  end 
end