class BrandsController < ApplicationController

  # POST /brands
  def create
    @brand = Brand.new(brand_params)
    respond_to do |format|
      if @brand.save
        format.json { render json: {result: 'success', data: @brand} }
      else
        format.json { render json: {result: 'error', error_messages: @brand.errors, full_error_messages: @brand.errors.full_messages} }
      end
    end
  end

  private

  def brand_params
    params.require(:brand).permit(:name)
  end


end
