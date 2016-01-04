Rails.application.routes.draw do
  root "welcome#index"
  get "events/new"
  get "/featured_events" => "welcome#featured"
  get "/popular_events" => "welcome#popular"
  get "/upcoming_events" => "welcome#index"
  get "/my_events" => "users#show"
  get "events/loading"
  post "/paypal_hook" => "bookings#paypal_hook", as: :hook
  post "/view" => "bookings#view_booking", as: :view_booking
  get "unattend", to: "attendees#destroy", as: "unattend"
  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: redirect("/")
  get "/tickets" => "bookings#index"
  get "/print/:booking_id(/:ticket_type_id)" => "printer#print", as: :print
  get "/download/:booking_id" => "printer#download", as: :download
  get "signout", to: "sessions#destroy", as: "signout"
  get "/session" => "sessions#create"
  post "/api_login" => "sessions#api_login"
  resources :manager_profiles
  resources :attendees
  resources :events do
    resources :bookings, only: [:create]
  end
  resources :users, only: [:show]
  get "*unmatched_route", to: "application#no_route_found"
end
