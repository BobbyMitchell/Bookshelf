Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 resources :books do
  collection do
    get "my_books", to: "books#my_books"
    end
    member do
      get "add_to_my_bookshelf"
    end

  resources :comments, only:[:new, :create]
 end


 root to: "books#index"
end
