class CoincidenceDecorator < Draper::Decorator
  delegate_all

  def vehicle
    "<a href='/vehicles/#{object.vehicle.id}'>#{decorated_vehicle.identification}</a>".html_safe
  end
  
  def buyer
    "<a href='/buyers/#{object.buyer.id}/edit'>#{decorated_buyer.full_name}</a>".html_safe
  end
  
  def phones
    object.buyer.phones
  end
  
  def notes
    h.truncate(object.buyer.notes, length: 30)
  end
  
  def action_button
    object.is_ignored? ? '' : link_to_edit
  end


  private
  
  def link_to_edit
    h.link_to 'Ignorar', 
      h.coincidence_path(object, 
        {coincidence: {is_ignored: true}}), 
          class: 'btn btn-xs btn-primary', method: :put
  end
  
  def decorated_buyer
    object.buyer.decorate
  end
  
  def decorated_vehicle
    object.vehicle.decorate
  end

end
