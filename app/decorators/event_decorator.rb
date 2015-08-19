class EventDecorator < Draper::Decorator
  # decorates :event
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def image_url(version)
    # object.image_url(version) || ""
    if object.image_url
        object.image_url(version)
    else
       ""
     end
  end

  def start_date
    if object.start_date
      object.start_date.strftime("%b %d %Y")
    else
       ""
     end
  end

  def end_date
    if object.end_date
      object.end_date.strftime("%b %d %Y")
    else
       ""
     end
   end

end
