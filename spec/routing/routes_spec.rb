require "rails_helper"
RSpec.describe "routing to controllers", type: :routing do
  it "routes root path to WelcomeController index action" do
    expect(get: "/").to route_to(
      controller: "welcome",
      action: "index"
    )
  end
  it "routes provider callback to sessions" do
    expect(get: "auth/:provider/callback").to route_to(
      controller: "sessions",
      action: "create",
      provider: ":provider"
    )
  end
  it "does not expose a list of bookings" do
    expect(get: "/bookings").to route_to(
      controller: "application",
      action: "no_route_found",
      unmatched_route: "bookings"
    )
  end
  it "gets featured events" do
    expect(get: "/featured_events").to be_routable
  end
  it "gets popular events" do
    expect(get: "/popular_events").to be_routable
  end
  it "routes /paypal_hook to Bookings" do
    expect(post: "/paypal_hook").to route_to(
      controller: "bookings",
      action: "paypal_hook"
    )
  end
  it "routes unattend to attendees#destroy" do
    expect(get: "/unattend").to route_to(
      controller: "attendees",
      action: "destroy"
    )
  end
  it "routes unmatched_route to ApplicationController" do
    expect(get: "*unmatched_route").to route_to(
      controller: "application",
      action: "no_route_found",
      unmatched_route: "*unmatched_route"
    )
  end
  it "routes signout to Sessions destroy action" do
    expect(get: "signout").to route_to(
      controller: "sessions",
      action: "destroy"
    )
  end
end
