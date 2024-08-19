Rails.application.routes.draw do
  root 'xml_processings#index'

  resources :xml_processings

end
