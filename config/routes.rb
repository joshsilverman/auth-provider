
StudyeggUserManager::Application.routes.draw do  
  
  devise_for :users, :controllers => { :registrations => 'registrations',
                                       :sessions => 'sessions'}
  # omniauth client stuff
  match '/auth/:provider/callback', :to => 'authentications#create'
  match '/auth/failure', :to => 'authentications#failure'
  match '/logout' => 'authentications#logout'

  # Provider stuff
  match '/oauth/user' => 'auth#user'
  match '/oauth/token' => 'auth#access_token'
  match '/oauth/authorize' => 'auth#authorize'

  # Account linking
  match 'authentications/:user_id/link' => 'authentications#link', :as => :link_accounts
  match 'authentications/:user_id/add' => 'authentications#add', :as => :add_account
 
  # API Calls
  match "api/get_groups_by_user_id" => "api#get_groups_by_user_id"
  match "api/get_students_by_teacher_id/:teacher_id" => "api#get_students_by_teacher_id"
  match "api/get_students_by_teacher_email" => "api#get_students_by_teacher_email"
  match "api/get_students_by_group_id" => "api#get_students_by_group_id"
  match "api/get_edmodo_id/:user_token" => "api#get_edmodo_id"
  match "api/export_all_users" => "api#export_all_users"

  devise_scope :user do
    #match 'users/credit_card' => 'registrations#credit_card'
    #match 'users/update_credit_card' => 'registrations#update_credit_card'
    match '/:id' => 'sessions#new'
    root :to => 'sessions#new'
  end
  
end
