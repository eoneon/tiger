Rails.application.routes.draw do
  resources :categories
  resources :photos
  root "photos#index"
end
