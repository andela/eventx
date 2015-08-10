module EventsHelper

  def all_template
    EventTemplate.order(:name)
  end

  def check_url(id)
    if id
      "/events/#{id}"
    else
      '/events/loading'
    end
  end
end
