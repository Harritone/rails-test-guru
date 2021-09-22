Rails.application.routes.draw do
  root to: 'quizzes#index'
  get :sign_up, to: 'users#new'
  get :sign_in, to: 'sessions#new'
  delete :sign_out, to: 'sessions#destroy'

  resources :users, only: :create
  resources :sessions, only: :create

  resources :quizzes do
    resources :questions, shallow: true, except: :index do
      resources :answers, shallow: true, except: :index
    end
    member do
      post :start
    end
  end

  resources :quiz_passages, controller: :taken_quizzes, only: %i[show update] do
    member do
      get :result
    end
  end
end
