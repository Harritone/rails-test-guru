Rails.application.routes.draw do
  root to: 'quizzes#index'
  post 'send_feedback', to: 'feedbacks#send_feedback'

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }

  resources :quizzes, only: :index do
  #   resources :questions, shallow: true, except: :index do
  #     resources :answers, shallow: true, except: :index
  #   end
    member do
      post :start
    end
  end

  resources :quiz_passages, controller: :taken_quizzes, only: %i[show update] do
    member do
      get :result
      post :gist
    end
  end

  namespace :admin do
    resources :quizzes do
      patch :update_inline, on: :member
      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end
    resources :gists, only: :index
  end
end
