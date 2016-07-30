class CustomersController < ApplicationController

  before_filter :set_customer, only: [:edit, :update, :destroy]

  # GET /customers
  def index
    @presenter = CustomersPresenter.new(params)
  end

  # GET /customers/new
  def new
    @modal_form = params[:modal] || false
    @customer = Customer.new
    if @modal_form
      render :new, layout: nil
    else
      render :new
    end
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)
    respond_to do |format|
      if @customer.save
        format.html { redirect_to customers_path, notice: 'El cliente ha sido creado correctamente.' }
        format.json { render json: {result: 'success', data: @customer} }
      else
        format.html { render :new }
        format.json { render json: {result: 'error', error_messages: @customer.errors, full_error_messages: @customer.errors.full_messages} }
      end
    end
  end

  # GET /customers/:id/edit
  def edit
  end

  # PUT /customers/:id
  def update
    if @customer.update(customer_params)
      redirect_to customers_path,
        notice: 'El cliente ha sido actualizado correctamente.'
    else
      render :edit
    end
  end

  # DELETE /customers/:id
  def destroy
    if @customer.destroy
      redirect_to customers_path,
        notice: 'El cliente ha sido eliminado correctamente.'
    else
      flash[:error] = 'Ocurrió un error al eliminar el cliente'
      redirect_to delegations_path
    end
  end

  # GET /customers/search
  def search
    block = ->(customer) { { id: customer.id, name: customer.to_s } }
    records = RecordSearcher.call(Customer.active, params, &block)
    render json: records.to_json, callback: params[:callback]
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
