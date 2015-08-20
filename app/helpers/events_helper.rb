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

  def getMap(map_url)
    new_map = (map_url || "https://maps.google.com/maps/place?q=Lagos,+Nigeria&ftid=0x103b8b2ae68280c1:0xdc9e87a367c3d9cb") + "&output=embed"
    # return
    new_map
  end
end
