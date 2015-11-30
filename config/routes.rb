Rails.application.routes.draw do
  root "welcome#index"
  get "events/new"
  get "welcome/index"
  get "welcome/featured"
  get "welcome/popular"
  get "events/loading"
  post "/paypal_hook" => "bookings#paypal_hook", as: :hook
  post "/view" => "bookings#view_booking", as: :view_booking
  get "unattend", to: "attendees#destroy", as: "unattend"
  resources :manager_profiles
  resources :attendees
  resources :events do
    resources :bookings, only: [:create]
  end
  get "/tickets" => "bookings#index"
  get "/print/:booking_id" => "printer#print", as: :print
  get "/download/:booking_id" => "printer#download", as: :download
  get "/session" => "sessions#create"
  resources :users, only: [:show]
  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: redirect("/")
  get "signout", to: "sessions#destroy", as: "signout"
  get "*unmatched_route", to: "application#no_route_found"
end
