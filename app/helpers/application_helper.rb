module ApplicationHelper
  def signin_path(provider)
    "/auth/#{provider.to_s}"
  end
end
