def set_valid_omniauth
  OmniAuth.config.add_mock(:google_oauth2, build_google_oauth2_response)
end

def set_invalid_omniauth
  OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
end

def build_google_oauth2_response(email = nil)
  OmniAuth::AuthHash.new(
    provider: "google_auth2", uid: "123456789",
    info: { name: "John Dummy", email: email || "johndummy@example.com",
            first_name: "John", last_name: "Dummy",
            image: "https://lh3.googleusercontent.com/url/photo.jpg"
          },
    credentials: { token: "token", refresh_token: "another_token",
                   expires_at: 1_354_920_555, expires: true
                 },
    extra: { raw_info: { sub: "123456789", email: "dummy@domain.example.com",
                         email_verified: true,
                         name: "John Dummy",
                         given_name: "John",
                         family_name: "Dummy",
                         profile: "https://plus.google.com/123456789",
                         picture: "https://plus.google.com/123456789",
                         gender: "male",
                         birthday: "1968-06-25",
                         locale: "en",
                         hd: "example.com"
                       }
            }
  )
end
