class BuyersPresenter

  def initialize(params)
    @params = params
    @filter = filter
  end

  def buyers
    @buyers ||= filter.call.page(@params[:page]).decorate
  end

  def filter
    @filter ||= BuyerFilter.new(filter_params)
  end

  private

  def filter_params
    if @params[:buyer_filter]
      parameters = @params.require(:buyer_filter).permit(:name, :from, :to)
    end
    parameters || {}
  end

end
