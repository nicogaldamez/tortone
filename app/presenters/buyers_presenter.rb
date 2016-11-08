class BuyersPresenter

  require "active_support/core_ext/hash/except"
  
  attr_accessor :errors

  def initialize(params)
    @params = params
    @errors = nil
    @filter = filter
  end

  def buyers
    @buyers ||= filter.call.page(@params[:page]).decorate
  end

  def filter
    @filter ||= BuyerFilter.new(filter_params)
  end
  
  def has_errors?
    @errors.present?
  end

  private

  def filter_params
    if @params[:buyer_filter]
      validate_dates()
      parameters = @params.require(:buyer_filter).permit(:name, :from, :to)
    end
    parameters || {}
  end
  
  def validate_dates
    params = @params[:buyer_filter]
    if params[:from].present? && params[:to].present?
      if params[:from].to_date > params[:to].to_date
        @params[:buyer_filter].except!(:from, :to)
        @errors = "No se ha aplicado el filtro por fechas. La fecha desde debe ser menor a la fecha hasta. "
      end
    end
  end

end
