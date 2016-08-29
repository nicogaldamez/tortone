class SalesPresenter
  include ActionView::Helpers::NumberHelper

  def initialize(params)
    @params = params
  end

  def sales
    @sales ||= filter.call.page(@params[:page]).decorate
  end

  def filter
    @filter ||= SaleFilter.new(filter_params)
  end

  def total_price
    number_to_currency(filter.call.sum(:price_in_cents)/10000 || 0)
  end

  def total_cash
    number_to_currency(filter.call.sum(:cash_in_cents)/10000 || 0)
  end
  
  def total_difference
    total = filter.call.decorate.map(&:unformatted_difference).reduce(:+)
    number_to_currency(total)
  end
  
  def total_cost
    total = filter.call.decorate.map(&:unformatted_vehicle_cost).reduce(:+)
    number_to_currency(total)
  end

  private

  def filter_params
    if @params[:sale_filter]
      parameters = @params.require(:sale_filter).permit(:vehicle_model_id, :from, :to)
    end
    parameters || {}
  end

end
