class CustomAuthenticationFailure < Devise::FailureApp 

  protected 
  
  def redirect_url
    referrer = request.env['HTTP_REFERER']
    ref = referrer.to_s
    ref.gsub!(/http:\/\//, '')
    if ref[-14..-1]=='zendolabs.com/'
      sub = ref[0..-16]
      sub = '' if sub == 'www'
    else
      sub = ''
    end
    
    #login_path
    "#{STUDYEGG_USER_MANAGER_PATH}/#{sub}"
  end 
end