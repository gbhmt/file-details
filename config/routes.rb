Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    resources :file_details, only: [:create, :index]
  end

end
