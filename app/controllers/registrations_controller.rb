class RegistrationsController < Devise::RegistrationsController
  #before_filter :save_referrer, :only => :edit

  def new
    @subdomain = 'default'
     # Building the resource with information that MAY BE available from omniauth!
     build_resource
     render_with_scope :new
  end
  
  def edit
    @subdomain = 'default'
    puts current_user.inspect
    @credit_card = current_user.credit_card
    super
  end

  def create
    build_resource

    if session[:omniauth] && @user.errors[:email][0] =~ /has already been taken/
      user = User.find_by_email(@user.email)
      # Link Accounts - if via social connect
      return redirect_to link_accounts_url(user.id)
    end

    # normal processing
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  def build_resource(*args)
    super

    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end

  def after_update_path_for(scope)
    session[:referrer] ? session[:referrer] : root_path
  end
  
  def credit_card
  end
  
  def update_credit_card
    puts "UPDATE CARD RUNNING"
    puts params.inspect
    puts current_user.inspect
    if current_user.stripe_customer_token
      puts "TOKEN EXISTS!"
      customer = Stripe::Customer.retrieve(current_user.stripe_customer_token)
      customer.card = params[:card_token]
      customer.save
      current_user.update_attributes(:credit_card => params[:last4])
    else
      puts "TOKEN NOT FOUND!"
      customer = Stripe::Customer.create(:card => params[:card_token], :email => current_user.email)
      current_user.update_attributes(:credit_card => params[:last4], :stripe_customer_token => customer.id)
    end
    render :nothing => true, :status => 200
  end
end
