Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 resources :books do
  resources :comments, only:[:new, :create]
 end

 root to: "books#index"
end
