Rails.application.routes.draw do
  root "employees#index"
  # get "/employees", to: "employees#index"
  # get "/employees/:id", to: "employees#show"
  resources :employees
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
