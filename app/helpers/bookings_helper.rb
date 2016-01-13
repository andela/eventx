module BookingsHelper
  # def link_to_remove_fields(name, f, cssClass = nil)
  #   fields = f.hidden_field(:_destroy)
  #   fields += link_to name, "#", onclick: "remove_fields(this)", class: cssClass
  #   fields
  # end

  def link_to_add_fields(name, f, model_class, association, cssclass, title)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object,
                          child_index: "new_#{association}") do |builder|
      render(model_class + "/" + association.to_s.singularize + "_fields", f:
             builder)
    end
    link_to name, "#", onclick: h("add_fields(this, '#{association}',
                                   \"#{escape_javascript(fields)}\")
    "), class: cssclass, title: title
  end
end
