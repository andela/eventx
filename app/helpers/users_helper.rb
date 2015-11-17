module UsersHelper
  def sign_in_provider
    {
      facebook: { name: "Facebook", class:
        "blue darken-3", icon_class: "fa-facebook" },
      twitter:  { name: "Twitter", class:
        "blue", icon_class: "fa-twitter" },
      google_oauth2: { name: "Google", class:
        "red darken-4", icon_class: "fa-google-plus" },
      linkedin: { name: "LinkedIn", class:
        "blue darken-4", icon_class: "fa-linkedin" },
      github: { name: "Github", class:
        "grey darken-4", icon_class: "fa-github" },
      tumblr: { name: "Tumblr", class:
        "blue-grey darken-3", icon_class: "fa-tumblr" }
    }
  end
end
