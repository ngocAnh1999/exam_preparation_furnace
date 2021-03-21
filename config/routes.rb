Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /en|vi/ do
    get "/", to: "home#index"

    root to: "home#index"
    devise_for :users, skip: :omniauth_callbacks,
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
    },
    path: 'auth', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      password: 'secret',
      confirmation: 'verification',
      unlock: 'unblock',
      registration: 'register',
      sign_up: 'cmon_let_me_in' }

    resources :users
    namespace :teachers do
      root to: "draft_tests#index"

      resources :draft_tests
    end
  end
end
