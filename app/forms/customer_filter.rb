class CustomerFilter
  include ActiveModel::Model
  attr_accessor :name

  def call(context=false)
    customers = Customer.all
    customers = customers.where('first_name like ? OR last_name like ?', "%#{@name}%", "%#{@name}%") if @name.present?
    customers
  end
end
