Rails.application.routes.draw do
  namespace :api do
    resources :transactions, only: :index
    resources :balances, only: :index

    put 'transactions/top_up'
    put 'transactions/buy'
    put 'transactions/sell'
  end
end
