class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :get_host
  
  def get_host
    @subdomain = 'default'
    @subdomain = request.subdomain if request.subdomain=='und'
  end
end
