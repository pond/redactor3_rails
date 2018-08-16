Redactor3Rails::Engine.routes.draw do
  resources :images, only: [:create, :index]
  resources :files, only: [:create, :index]
end
