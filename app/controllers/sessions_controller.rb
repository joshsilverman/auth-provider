class SessionsController < Devise::SessionsController
  def new
    set_subdomain(params[:id])
    super
  end
  
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(resource)
  end
  
  def destroy
    signed_in = signed_in?(resource_name)
    redirect_path = after_sign_out_path_for(resource_name)
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
#    set_flash_message :notice, :signed_out if signed_in

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    redirect_to "http://#{STUDYEGG_STORE_PATH}"
#    respond_to do |format|
#      format.any(*navigational_formats) { redirect_to redirect_path }
#      format.all do
#        method = "to_#{request_format}"
#        text = {}.respond_to?(method) ? {}.send(method) : ""
#        render :text => text, :status => :ok
#      end
#    end
  end
end