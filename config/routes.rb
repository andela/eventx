Rails.application.routes.draw do
  root "welcome#index"
  get "events/new"
  post "/events/:event_id/manage_staffs" => "manager_profiles#save_staffs",
       as: :save_staffs
  get "/events/:event_id/manage_staffs" => "manager_profiles#manage_staffs",
      as: :manage_staffs
  get "/events/:event_id/remove_staff/:event_staff_id" =>
    "manager_profiles#remove_staff", as: :remove_staff
  get "/events/:id/enable" =>
          "events#enable", as: :enable_event
  get "/events/:id/disable" =>
          "events#disable", as: :disable_event
  get "/events/:id/generate" => "events#generate", as: :generate_event
  get "/featured_events" => "welcome#featured"
  get "/popular_events" => "welcome#popular"
  get "/upcoming_events" => "welcome#index"
  get "/my_events" => "users#show"
  get "events/loading"
  get "/lookup_staffs" => "users#lookup_staff_emails"
  get "/user_info/:user_id" => "users#fetch_user_info"
  post "/paypal_hook" => "bookings#paypal_hook", as: :hook
  post "/paypal_dummy" => "bookings#paypal_dummy", as: :paypal_dummy
  get "unattend", to: "attendees#destroy", as: "unattend"
  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: redirect("/")
  get "/tickets" => "bookings#index"
  get "/events/:id/tickets" =>
          "events#tickets", as: :event_tickets
  get "/print/:booking_id(/:ticket_type_id)" => "printer#print", as: :print
  post "/print/:id" => "printer#redirect_to_print"
  get "/print/:id" => "printer#redirect_to_print"
  get "/download/:booking_id" => "printer#download", as: :download
  get "signout", to: "sessions#destroy", as: "signout"
  get "/session" => "sessions#create"
  post "/api_login" => "sessions#api_login"
  resources :manager_profiles, only: [:new, :create]
  resources :attendees
  resources :categories
  resources :events do
    resources :bookings, only: [:create]
  end
  get "/remit/:id", to: "remit#new", as: :remit
  get "/download/:id", to: "remit#download", as: :download_remit
  get "/events/:id/:highlight_id" =>
    "events#show_event_highlight", as: :show_event_highlight
  resources :users, only: [:show]
  get "*unmatched_route", to: "application#no_route_found"
end
