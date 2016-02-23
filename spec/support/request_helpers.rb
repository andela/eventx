module Requests
  module JsonHelper
    def json
      JSON.parse(response.body)
    end
  end

  module ApiHelper
    def url
      "https://graph.facebook.com/me?fields=id,name,email,picture"
    end

    def mock_httparty_request(token = nil)
      user = FactoryGirl.create(:user)
      name = user.first_name + " " + user.last_name
      status = 200
      status = 417 if token == "invalid_token"
      body = { id: user.uid, name: name, email: user.email }
      stub_request(:get, url).
        with(headers: { "Access_token"  => "token",
                        "Authorization" => "OAuth token" }).
        to_return(body: body.to_json, status: status)
    end

    def signin
      mock_httparty_request
      params = { provider: "facebook", token: "token" }
      post :api_login, params
      @api_key = json["api_key"]
    end
  end
end
