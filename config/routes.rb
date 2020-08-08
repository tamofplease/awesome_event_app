Rails.application.routes.draw do
  root 'welcome#index'
  get "/auth/:provider/callback" => "sessions#create"
  delete "/logout" => "sessions#destory"
  
  resources :events, only: %i[new create show edit update destroy] do
    resources :tickets, only: %i[new create destroy]
  end

  resource :retirements, only: %i[new create]

  get 'status' => 'status#index', defaults: {format: 'json'}
  match "*path" => "application#error404", via: :all
end
