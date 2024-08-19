Rails.application.routes.draw do
  root 'home#index'

  resources :xml_processings

end
