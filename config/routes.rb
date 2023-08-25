Rails.application.routes.draw do
  resources :categories
  resources :photos
  resources :search_photos
  root "photos#index"
end
