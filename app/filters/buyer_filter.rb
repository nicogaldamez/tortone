class BuyerFilter
  include ActiveModel::Model
  attr_accessor :name, :from, :to

  def call
    buyers = Buyer.all
    buyers = buyers.where('first_name ilike ? OR last_name ilike ?', "%#{@name}%", "%#{@name}%") if @name.present?
    buyers = buyers.where('created_at >= ?', @from) if @from.present?
    buyers = buyers.where('created_at <= ?', @to) if @to.present?
    buyers
  end
end
