Rails.application.routes.draw do
  root "google_domains#index"
  resources :google_domains
  get "/oauth2callback", to: "google_domains#update"
end
