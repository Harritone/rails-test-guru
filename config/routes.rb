Rails.application.routes.draw do
  root to: 'quizzes#index'

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }

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
