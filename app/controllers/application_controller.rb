class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :get_host
  
  def get_host
    @host = request.host_with_port
  end
end
