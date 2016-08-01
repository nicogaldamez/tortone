class CoincidencesPresenter

  def initialize(params)
    @params = params
    @filter = filter
  end

  def coincidences
    @coincidences ||= filter.call.page(@params[:page]).decorate
  end

  def filter
    @filter ||= CoincidenceFilter.new(filter_params)
  end

  private

  def filter_params
    if @params[:coincidence_filter]
      parameters = @params.require(:coincidence_filter).permit(:vehicle_model)
    end
    parameters || {}
  end

end
