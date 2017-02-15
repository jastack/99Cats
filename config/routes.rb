Rails.application.routes.draw do
  resources :cats, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :cat_rental_requests, only: [:index, :show, :new, :create, :edit, :update, :destroy] 

end
