Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  scope 'api', format: :json do
    jsonapi_resources :accounts
  end

  namespace :pdf, format: :pdf do
    get :chart_of_accounts, to: 'chart_of_accounts#chart_of_accounts'
  end
end
