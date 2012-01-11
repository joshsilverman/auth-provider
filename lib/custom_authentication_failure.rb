class CustomAuthenticationFailure < Devise::FailureApp 

  protected 
  
  def redirect_url
    login_path
  end 
end