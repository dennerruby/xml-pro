Rails.application.routes.draw do
   # Rotas do Devise para usuários
  devise_for :users
  resources :xml_processings
 
end
