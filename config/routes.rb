Rails.application.routes.draw do
  apipie
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :todo_items do
    member do
      put :undo_deleted_item
    end
  end
end
