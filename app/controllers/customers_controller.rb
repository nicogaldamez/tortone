class CustomersController < ApplicationController

  before_filter :set_customer, only: [:edit, :update, :destroy]

  def index
    @presenter = CustomersPresenter.new(params)
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path,
        notice: 'El cliente ha sido creado correctamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customers_path,
        notice: 'El cliente ha sido actualizado correctamente.'
    else
      render :edit
    end
  end

  def destroy
    if @customer.destroy
      redirect_to customers_path,
        notice: 'El cliente ha sido eliminado correctamente.'
    else
      flash[:error] = 'Ocurrió un error al eliminar el cliente'
      redirect_to delegations_path
    end
  end


  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email,
                                     :phones, :dni, :address, :description)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

end
