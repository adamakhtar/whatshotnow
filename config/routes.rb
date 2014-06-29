Rails.application.routes.draw do
  
  
  resources :products, only: [:index, :show]
  

  devise_for :users

  root to: 'sessions#new'
end
