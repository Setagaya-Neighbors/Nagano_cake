class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @addresses = Address.where(customer_id: current_customer)

    @new_address = Address.new
  end

  def create
     @new_address = Address.new(address_params)
     @new_address.customer_id = current_customer.id
    if  @new_address.save
      redirect_to public_addresses_path, notice: "You have created address successfully."
    else
      @addresses = Address.where(customer_id: current_customer.id)
      render :index

    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
     @address = Address.find(params[:id])

     if @address.update(address_params)
      flash[:createdflag] = true
      flash[:notice]= "You have updated user successfully."
      redirect_to public_addresses_path
     else
      render :edit
     end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to public_addresses_path, notice: "You have destroyed address successfully."
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end

