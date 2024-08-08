Rails.application.routes.draw do
 


  resources :genres do
    resources :books
    end
    
root "genres#index"


end
