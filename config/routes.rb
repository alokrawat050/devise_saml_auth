Rails.application.routes.draw do
  root 'home#index'
  
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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
