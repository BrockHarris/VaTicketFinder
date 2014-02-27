UVAtickets::Application.routes.draw do
  
  resources :resultlogs
  root :to => 'main#home'
end
