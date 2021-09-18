Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
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
