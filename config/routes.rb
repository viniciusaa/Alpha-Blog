Rails.application.routes.draw do
  devise_for :users
  root "pages#home"
  get "about", to: "pages#about"
  resources :articles do
    resources :comments
  end
end
