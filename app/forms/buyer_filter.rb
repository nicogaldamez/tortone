class BuyerFilter
  include ActiveModel::Model
  attr_accessor :name

  def call(context=false)
    buyers = Buyer.all
    buyers = buyers.where('first_name ilike ? OR last_name ilike ?', "%#{@name}%", "%#{@name}%") if @name.present?
    buyers
  end
end
