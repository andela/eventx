             Prefix Verb   URI Pattern                                       Controller#Action
               root GET    /                                                 welcome#index
            popular GET    /events/popular(.:format)                         events#popular
       enable_event GET    /events/:id/enable(.:format)                      events#enable
      disable_event GET    /events/:id/disable(.:format)                     events#disable
     generate_event GET    /events/:id/generate(.:format)                    events#generate
         gatekeeper GET    /events/:id/scan(.:format)                        events#scan
      event_tickets GET    /events/:id/tickets(.:format)                     events#tickets
     tickets_report GET    /events/:id/tickets-report(.:format)              events#tickets_report
    featured_events GET    /featured-events(.:format)                        welcome#featured
     popular_events GET    /popular_events(.:format)                         welcome#popular
    upcoming_events GET    /upcoming-events(.:format)                        welcome#index
        save_staffs POST   /manage-staffs/:event_id(.:format)                manager_profiles#save_staffs
      manage_staffs GET    /manage-staffs/:event_id(.:format)                manager_profiles#manage_staffs
       remove_staff GET    /remove-staff/:event_id/:event_staff_id(.:format) manager_profiles#remove_staff
             refund POST   /refund/:uniq_id(.:format)                        bookings#request_refund
       grant_refund GET    /refund/:uniq_id(.:format)                        bookings#grant_refund
        paypal_hook POST   /paypal_hook(.:format)                            bookings#paypal_hook
        scan_ticket GET    /scan-ticket(.:format)                            bookings#scan_ticket
               scan GET    /scan-ticket/:ticket_no(.:format)                 bookings#use_ticket
            tickets GET    /tickets(.:format)                                bookings#index
                    GET    /auth/:provider/callback(.:format)                sessions#create
            signout GET    /signout(.:format)                                sessions#destroy
            session GET    /session(.:format)                                sessions#create
          api_login POST   /api_login(.:format)                              sessions#api_login
          dashboard GET    /dashboard(.:format)                              users#show
      lookup_staffs GET    /lookup_staffs(.:format)                          users#lookup_staff_emails
                    GET    /user_info/:user_id(.:format)                     users#fetch_user_info
              print GET    /print/:booking_id(/:ticket_type_id)(.:format)    printer#print
           download GET    /download/:booking_id(.:format)                   printer#download
               user GET    /users/:id(.:format)                              users#show
   manager_profiles POST   /manager_profiles(.:format)                       manager_profiles#create
new_manager_profile GET    /manager_profiles/new(.:format)                   manager_profiles#new
          attendees GET    /attendees(.:format)                              attendees#index
                    POST   /attendees(.:format)                              attendees#create
       new_attendee GET    /attendees/new(.:format)                          attendees#new
      edit_attendee GET    /attendees/:id/edit(.:format)                     attendees#edit
           attendee GET    /attendees/:id(.:format)                          attendees#show
                    PATCH  /attendees/:id(.:format)                          attendees#update
                    PUT    /attendees/:id(.:format)                          attendees#update
                    DELETE /attendees/:id(.:format)                          attendees#destroy
         categories GET    /categories(.:format)                             categories#index
                    POST   /categories(.:format)                             categories#create
       new_category GET    /categories/new(.:format)                         categories#new
      edit_category GET    /categories/:id/edit(.:format)                    categories#edit
           category GET    /categories/:id(.:format)                         categories#show
                    PATCH  /categories/:id(.:format)                         categories#update
                    PUT    /categories/:id(.:format)                         categories#update
                    DELETE /categories/:id(.:format)                         categories#destroy
     event_bookings POST   /events/:event_id/bookings(.:format)              bookings#create
     event_sponsors GET    /events/:event_id/sponsors(.:format)              sponsors#index
                    POST   /events/:event_id/sponsors(.:format)              sponsors#create
  new_event_sponsor GET    /events/:event_id/sponsors/new(.:format)          sponsors#new
 edit_event_sponsor GET    /events/:event_id/sponsors/:id/edit(.:format)     sponsors#edit
      event_sponsor GET    /events/:event_id/sponsors/:id(.:format)          sponsors#show
                    PATCH  /events/:event_id/sponsors/:id(.:format)          sponsors#update
                    PUT    /events/:event_id/sponsors/:id(.:format)          sponsors#update
                    DELETE /events/:event_id/sponsors/:id(.:format)          sponsors#destroy
      event_reviews POST   /events/:event_id/reviews(.:format)               reviews#create
             events GET    /events(.:format)                                 events#index
                    POST   /events(.:format)                                 events#create
          new_event GET    /events/new(.:format)                             events#new
         edit_event GET    /events/:id/edit(.:format)                        events#edit
              event GET    /events/:id(.:format)                             events#show
                    PATCH  /events/:id(.:format)                             events#update
                    PUT    /events/:id(.:format)                             events#update
                    DELETE /events/:id(.:format)                             events#destroy
           unattend GET    /unattend(.:format)                               attendees#destroy
              remit GET    /remit/:id(.:format)                              remit#new
                    GET    /*unmatched_route(.:format)                       application#no_route_found
