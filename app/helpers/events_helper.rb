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
    if map_url.nil? || map_url.strip.empty?
      new_map = ("https://maps.google.com/maps/place?q=Lagos,+Nigeria&ftid=0x103b8b2ae68280c1:0xdc9e87a367c3d9cb") + "&output=embed"
    else
      new_map = map_url + "&output=embed"
    end
  end
end
