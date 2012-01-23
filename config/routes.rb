StudyeggUserManager::Application.routes.draw do  
  
  devise_for :users, :controllers => { :registrations => 'registrations',
                                       :sessions => 'sessions'}
  # omniauth client stuff
  match '/auth/:provider/callback', :to => 'authentications#create'
  match '/auth/failure', :to => 'authentications#failure'
  match '/logout' => 'authentications#logout'

  # edmodo
  match '/install' => 'auth#install'

  # Provider stuff
  match '/oauth/user' => 'auth#user'
  match '/oauth/token' => 'auth#access_token'
  match '/oauth/authorize' => 'auth#authorize'

  # Account linking
  match 'authentications/:user_id/link' => 'authentications#link', :as => :link_accounts
  match 'authentications/:user_id/add' => 'authentications#add', :as => :add_account
 
  devise_scope :user do
    #match 'users/credit_card' => 'registrations#credit_card'
    #match 'users/update_credit_card' => 'registrations#update_credit_card'
    match '/:id' => 'sessions#new'
    root :to => 'sessions#new'
  end
  
end
