class CustomersPresenter

  def initialize(params)
    @params = params
    @filter = filter
  end

  def customers
    @customers ||= filter.call.page(@params[:page]).decorate
  end

  def filter
    @filter ||= CustomerFilter.new(filter_params)
  end

  private

  def filter_params
    if @params[:customer_filter]
      parameters = @params.require(:customer_filter).permit(:name, :vehicle)
    end
    parameters || {}
  end

end
