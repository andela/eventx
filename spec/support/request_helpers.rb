module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
  end

  module ApiHelper
    def user_token
      "CAAGE0WLOkNYBAPOHM5r8JOrJBut7zr6G46REZBfgbUnYQ7vCN4CrQimI60OH7\
      gkIALgQTN5f6urenbL8IHb27NFKvk6n380ZCeYSyAp19ZCuYDQZBsrveZA96IJBm\
      ZB9LTJ1vxBcgSalhVeZCsREvwnB8i08LjbBYLBWx44FSFvPLr1GyLQN9e2u9okfBuI67cZD"
    end

    def signin
      params = { provider: "facebook", token: user_token }
      post :api_login, params
      @api_key = json["api_key"]
    end

    def api_key
      @api_key
    end

    def create_api_event
      event = FactoryGirl.attributes_for(:event)
      request.headers["Authorization"] = "#{@api_key}"
      post :create, event: event, format: "json"
      @event = json["event"]
    end

    def event
      @event
    end
  end
end
