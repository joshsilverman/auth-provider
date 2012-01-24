class AuthController < ApplicationController
  before_filter :authenticate_user!, :except => [:access_token, :authorize, :install, :launch]
  before_filter :_authenticate_user, :only => [:authorize]
  skip_before_filter :verify_authenticity_token, :only => [:access_token]
  
  def welcome
    if params[:id]
      redirect_to "http://#{params[:id]}.#{STUDYEGG_PATH}"
    else
      redirect_to "http://www.#{STUDYEGG_PATH}"
    end
#    render :text => "Hiya! #{current_user.first_name} #{current_user.last_name}"
  end

  def install
    install = JSON.parse(params[:install])
    puts install
    user_tokens = ["\"#{install['user_token']}\""]
    user = Edmodo.users(user_tokens)
    puts user_tokens
    puts user
    render :json => {:status => "success"}
  end

  def launch
    user = Edmodo.launch_requests(params[:launch_key])
    #user = {"user_token" => "123456789", "first_name" => "Bill", "last_name" => "DeRusha",
    #        "email" => "", "user_type" => "TEACHER"}
    puts user
    session['edmodo'] = edmodo_omniauth(user)
    redirect_to "/auth/edmodo/callback"
  end

  def edmodo_omniauth(user)
    user['email'] = "#{user['user_token']}edmodo@studyegg.com" if user['email'].nil?
    omniauth = {"provider"=>"edmodo",
                            "uid"=>"#{user['user_token']}",
                            "info"=>{"name"=>"#{user['first_name']} #{user['last_name']}",
                                    "email"=>"#{user['email'] if user['email']}",
                                    "first_name"=>"#{user['first_name']}",
                                    "last_name"=>"#{user['last_name']}",
                                    "school"=>"edmodo",
                                    "user_type"=>"#{user['user_type']}",
                                    "user_token"=>"#{user['user_token']}"},
                            "credentials"=>{"token"=>"",
                                    "refresh_token"=>"",
                                    "expires_at"=>nil,
                                    "expires"=>false},
                            "extra"=>{
                              "user_hash"=>{"provider"=>"edmodo",
                                                "uid"=>"#{user['user_token']}",
                                                "info"=>{"name"=>"#{user['first_name']} #{user['last_name']}",
                                                        "email"=>"#{user['email'] if user['email']}",
                                                        "first_name"=>"#{user['first_name']}",
                                                        "last_name"=>"#{user['last_name']}",
                                                        "school"=>"edmodo",
                                                        "user_type"=>"#{user['user_type']}",
                                                        "user_token"=>"#{user['user_token']}"}}}}
    omniauth
  end

  def create_edmodo_user(omniauth)
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    unless authentication
      user = User.new
      user.apply_omniauth(omniauth)
      user.email = omniauth['extra'] && omniauth['extra']['user_hash'] && (omniauth['extra']['user_hash']['email'] || (omniauth['extra']['user_hash']['info'] && omniauth['extra']['user_hash']['info']['email']))
      user.first_name = omniauth['extra'] && omniauth['extra']['user_hash'] && (omniauth['extra']['user_hash']['first_name'] || (omniauth['extra']['user_hash']['info'] && omniauth['extra']['user_hash']['info']['first_name']))
      user.last_name = omniauth['extra'] && omniauth['extra']['user_hash'] && (omniauth['extra']['user_hash']['last_name'] || (omniauth['extra']['user_hash']['info'] && omniauth['extra']['user_hash']['info']['last_name']))
      user.school = user.first_name = omniauth['extra'] && omniauth['extra']['user_hash'] && omniauth['extra']['user_hash']['info'] && omniauth['extra']['user_hash']['info']['school']
      user.user_type = omniauth['extra'] && omniauth['extra']['user_hash'] && omniauth['extra']['user_hash']['info'] && omniauth['extra']['user_hash']['info']['user_type']
      user.user_token = omniauth['extra'] && omniauth['extra']['user_hash'] && omniauth['extra']['user_hash']['info'] && omniauth['extra']['user_hash']['info']['user_token']

      if user.save
        puts "Created User: #{user.first_name} #{user.last_name} - #{user.user_token}"
      else
        puts "Error saving user #{omniauth['uid']}"
      end
    end
  end

  def authorize
    AccessGrant.prune!
    access_grant = current_user.access_grants.create(:client => application)
    redirect_to access_grant.redirect_uri_for(params[:redirect_uri])
  end

  def access_token
    application = Client.authenticate(params[:client_id], params[:client_secret])

    if application.nil?
      render :json => {:error => "Could not find application"}
      return
    end

    access_grant = AccessGrant.authenticate(params[:code], application.id)
    if access_grant.nil?
      render :json => {:error => "Could not authenticate access code"}
      return
    end

    access_grant.start_expiry_period!
    render :json => {:access_token => access_grant.access_token, :refresh_token => access_grant.refresh_token, :expires_in => Devise.timeout_in.to_i}
  end

  def failure
    render :text => "ERROR: #{params[:message]}"
  end

  def user
    hash = {
      :provider => 'identity',
      :uid => current_user.id.to_s,
      :info => {
        :name => [current_user.first_name, current_user.last_name].join(" "),
        :email => current_user.email,
        :first_name => current_user.first_name,
        :last_name => current_user.last_name,
        :school => current_user.school,
        :user_type => current_user.user_type,
        :user_token => current_user.user_token
      }
    }
    render :json => hash.to_json
  end

  # Incase, we need to check timeout of the session from a different application!
  # This will be called ONLY if the user is authenticated and token is valid
  # Extend the UserManager session
  def isalive
    warden.set_user(current_user, :scope => :user)
    response = { 'status' => 'ok' }

    respond_to do |format|
      format.any { render :json => response.to_json }
    end
  end

  protected

  def application
    @application ||= Client.find_by_app_id(params[:client_id])
  end

end
