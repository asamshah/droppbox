Rails.application.routes.draw do
  resources :documents do
    member do
      get 'share'
    end
  end
  get 'shared/:share_token', to: 'documents#shared', as: 'document_share'
  
  devise_for :users
  root 'documents#index'
end