class BuyersController < ApplicationController

  before_filter :set_buyer, only: [:edit, :update, :destroy]

  # GET /buyers
  def index
    @presenter = BuyersPresenter.new(params)
    if @presenter.has_errors?
      flash[:error] = @presenter.errors
    end
  end

  # GET /buyers/new
  def new
    @buyer = Buyer.new
    @buyer.buyer_interests.new
  end

  # POST /buyers
  def create
    @buyer = Buyer.new(buyer_params)
    if @buyer.save
      CoincidenceFinder.call(buyer: @buyer)
      
      redirect_to buyers_path, notice: 'El interesado ha sido creado correctamente.'
    else
      render :new
    end
  end

  # GET /buyers/:id/edit
  def edit
  end

  # PUT /buyers/:id
  def update
    if @buyer.update(buyer_params)
      CoincidenceFinder.call(buyer: @buyer)
      
      redirect_to buyers_path,
        notice: 'El interesado ha sido actualizado correctamente.'
    else
      render :edit
    end
  end

  # DELETE /buyers/:id
  def destroy
    if @buyer.destroy
      redirect_to buyers_path,
        notice: 'El interesado ha sido eliminado correctamente.'
    else
      flash[:error] = 'Ocurrió un error al eliminar el interesado'
      redirect_to buyers_path
    end
  end


  private

  def buyer_params
    params.require(:buyer).permit(:first_name, :last_name, :phones, :email,
                                  :max_price, :notes, :is_hdi,
                                  :has_automatic_transmission,
                                  buyer_interests_attributes: [:vehicle_model_id,
                                    :id, :_destroy, :brand_id, :max_kilometers, :year])
  end

  def set_buyer
    @buyer = Buyer.find(params[:id])
  end

end
