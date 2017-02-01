Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  namespace :pdf, format: :pdf do
    get :test, to: 'test#test'
  end

end
