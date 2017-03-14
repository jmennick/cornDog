Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # used to get the user_token (for authentication)
  # this is in the JWT format (via the Knock gem)
  post 'user_token' => 'user_token#create'

  scope 'api', format: :json do
    jsonapi_resources :accounts
    jsonapi_resources :journal_entries
  end

  namespace :pdf, format: :pdf do
    get :chart_of_accounts, to: 'chart_of_accounts#chart_of_accounts'
  end
end
