Rails.application.routes.draw do
  root 'home#index'

  # devise_for :users
  # devise_for :users, skip: :all
  # database_authenticatable users
  # get "login" => "auth#login", as: :new_user_session
  # post "auth" => "auth#index", as: :user_session
  # get "auth/logout" => "auth#logout", as: :destroy_user_session

  devise_for :users, skip: :saml_authenticatable, controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions",
    passwords: "user/passwords"
  }
  
  # opt-in saml_authenticatable
  devise_scope :user do
    scope "users", controller: 'saml_sessions' do
      get :new, path: "saml/sign_in", as: :new_user_sso_session
      post :create, path: "saml/auth", as: :user_sso_session
      get :destroy, path: "sign_out", as: :destroy_user_sso_session
      get :metadata, path: "saml/metadata", as: :metadata_user_sso_session
      match :idp_sign_out, path: "saml/idp_sign_out", via: [:get, :post]
    end
  end
#   devise_scope :users do
#     get '/sign_in' => 'sessions#new'
#     get '/sign_out' => 'sessions#destroy'    

#     # SSO Routes
#     get 'saml/sign_in' => 'saml_sessions#new', as: :new_user_sso_session
#     post 'saml/auth' => 'saml_sessions#create', as: :user_sso_session
#     get 'saml/sign_out' => 'saml_sessions#destroy', as: :destroy_user_sso_session
#     get 'saml/metadata' => 'saml_sessions#metadata', as: :metadata_user_sso_session
#     match 'saml/idp_sign_out' => 'saml_sessions#idp_sign_out', via: [:get, :post]
# end
  # devise_for :users, :controllers => {
  #     registrations: 'users/registrations',
  #     sessions: 'users/sessions'
  # }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
