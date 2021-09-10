Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :quizzes do
    resources :questions
  end

  post '/quizzes/:quiz_id/questions/:id', to: 'questions#destroy'
end
