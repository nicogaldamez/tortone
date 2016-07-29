class SalesPresenter

  def initialize(params)
    @params = params
  end

  def sales
    @sales ||= filter.call.page(@params[:page]).decorate
  end

  def filter
    @filter ||= SaleFilter.new(filter_params)
  end

  private

  def filter_params
    if @params[:sale_filter]
      parameters = @params.require(:sale_filter).permit(:vehicle_model_id, :from, :to)
    end
    parameters || {}
  end

end
