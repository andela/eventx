Rails.application.routes.draw do
  root "welcome#index"

  scope path: "/events", controller: :events do
    get "popular"            => :popular
    get ":id/enable"         => :enable, as: :enable_event
    get ":id/disable"        => :disable, as: :disable_event
    get ":id/generate"       => :generate, as: :generate_event
    get ":id/scan"           => :scan, as: :gatekeeper
    get ":id/tickets"        => :tickets, as: :event_tickets
    get ":id/tickets-report" => :tickets_report, as: :tickets_report
  end

  scope controller: :welcome do
    get "/featured-events"           => :featured
    get "/popular_events"            => :popular
    get "/upcoming-events"           => :index
    get "/about"                     => :about
  end

  scope controller: :manager_profiles do
    post "/manage-staffs/:event_id" => :save_staffs, as: :save_staffs
    get "/manage-staffs/:event_id" => :manage_staffs, as: :manage_staffs
    get "/remove-staff/:event_id/:event_staff_id" => :remove_staff,
        as: :remove_staff
  end

  scope controller: :bookings do
    post "/refund/:uniq_id"           => :request_refund, as: :refund
    get "/refund/:uniq_id"            => :grant_refund, as: :grant_refund
    post "/paypal_hook"               => :paypal_hook, as: :paypal_hook
    get "/scan-ticket"                => :scan_ticket, as: :scan_ticket
    get "/scan-ticket/:ticket_no"     => :use_ticket, as: :scan
    get "/tickets"                    => :index
  end

  scope controller: :sessions do
    get "/auth/:provider/callback" => :create
    get "/signout"                 => :destroy, as: :signout
    get "/session"                 => :create
    post "/api_login"              => :api_login
  end

  scope controller: :users do
    get "/dashboard" => :show
    get "/lookup_staffs"      => :lookup_staff_emails
    get "/user_info/:user_id" => :fetch_user_info
  end

  scope controller: :printer do
    get "/print/:booking_id(/:ticket_type_id)" => "printer#print", as: :print
    get "/download/:booking_id" => "printer#download", as: :download
  end

  resources :users, only: [:show]
  resources :manager_profiles, only: [:new, :create]
  resources :attendees
  resources :categories
  resources :events do
    resources :bookings, only: [:create]
    resources :sponsors
    resources :reviews, only: [:create]
    resources :subscriptions, only: [:new, :create, :destroy]
  end

  get "/unattend", to: "attendees#destroy", as: :unattend
  get "/remit/:id", to: "remit#new", as: :remit
  get "*unmatched_route", to: "application#no_route_found"
end
