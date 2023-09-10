Rails.application.routes.draw do
  devise_for :users
  mount ImageUploader.derivation_endpoint => "/derivations/image"
  resources :categories
  resources :photos
  resources :search_photos
  resources :sort_photos

  root "photos#index"
end
