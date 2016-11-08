class BuyerFilter
  include ActiveModel::Model
  attr_accessor :name, :from, :to

  def call
    buyers = Buyer.all
    buyers = buyers.where('first_name ilike ? OR last_name ilike ?', "%#{@name}%", "%#{@name}%") if @name.present?
    buyers = buyers.where('created_at >= ?', _from) if @from.present?
    buyers = buyers.where('created_at <= ?', _to) if @to.present?
    buyers
  end
  
  private
  
  def _from
    @from.to_date.beginning_of_day
  end
  
  def _to
    @to.to_date.end_of_day
  end
end
