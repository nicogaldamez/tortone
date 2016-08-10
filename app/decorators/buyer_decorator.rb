class BuyerDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{last_name} #{first_name}"
  end
  
  def email
    object.email.blank? ? '-' : object.email
  end

end
