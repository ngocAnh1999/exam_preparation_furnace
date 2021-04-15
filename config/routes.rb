Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /en|vi/ do
    get "/", to: "home#index"
    concern :paginatable do
      get '(page/:page)', action: :index, on: :collection, as: ''
    end

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
      root to: "tests#index"

      resources :tests, concerns: :paginatable

      resources :draft_tests, concerns: :paginatable do
        get :search_chapters, on: :collection
        get :teacher_same_subjects, on: :collection
        get :new_test, on: :member
      end
    end
  end
end
