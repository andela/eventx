class SubdomainConstraint
  def matches?(request)
    event = Event.find_by(subdomain: request.subdomain)
    event.present? && request.subdomain.present?
  end
end