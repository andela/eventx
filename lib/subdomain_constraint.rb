class SubdomainConstraint
  def matches?(request)
    event = Event.find_by(subdomain: request.subdomain)
    !event.nil?
  end
end