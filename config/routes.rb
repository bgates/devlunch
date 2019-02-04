Rails.application.routes.draw do
  resources :invitations, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
