Rails.application.routes.draw do

  resources :manager_profiles

  get "events/new"

  get "welcome/index"
  get "welcome/featured"
  get "welcome/popular"
  get "events/loading"
  # resources :bookings
  post "/paypal_hook" => "bookings#paypal_hook", as: :hook
  post "/view" => "bookings#view_booking", as: :view_booking
  get "unattend", to: "attendees#destroy", as: "unattend"
  resources :attendees
  # post "\bookings"
  # resources :bookings, only: [:create]
  resources :events do
    resources :bookings, only: [:create]
  end
  get "/session" => "sessions#create"
  resources :users, only: [:show]
  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: redirect("/")
  get "signout", to: "sessions#destroy", as: "signout"
  get "*unmatched_route", to: "application#no_route_found"

  root "welcome#index"

end
