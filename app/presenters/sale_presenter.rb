class SalePresenter
  include ActionView::Helpers::UrlHelper
  ActionView::Base.send(:include, Rails.application.routes.url_helpers)

  attr_reader :sale

  def initialize(sale)
    @sale = sale.decorate
  end

  def sold_on
    if @sale.sold_on
      @sale.sold_on
    else
      link_to 'Cargar Fecha', Rails.application.routes.url_helpers.edit_sale_path(@sale),
        class: 'btn btn-xs btn-default'
    end
  end

end
