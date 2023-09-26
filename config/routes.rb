Rails.application.routes.draw do
  resources :original_photos
  #get 'welcome/about'
  mount Lockup::Engine, at: '/lockup'
  devise_for :users

  mount ImageUploader.derivation_endpoint => "/derivations/image"

  resources :categories
  resources :photos do
    resources :original_photos, except: [:index]
  end
  resources :search_photos
  resources :sort_photos

  root "welcome#about"
end
