module EventsHelper

  def all_template
    EventTemplate.order(:name)
  end
end
