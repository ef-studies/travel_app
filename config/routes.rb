Rails.application.routes.draw do
  resources :travels
  root 'travels#index'
end
