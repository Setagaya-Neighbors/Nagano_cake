class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @new_address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to public_address_path(@address), notice: "You have created address successfully."
    else
      @address = Address.all
      render 'index'
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
     @address = Address.find(params[:id])
     @address.update(address_params)
     redirect_to public_address_path(@address), notice: "You have updated address successfully."
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to public_addresses_path, notice: "You have destroyed address successfully."
  end
  
  private

  def address_params
    params.require(:address).permit(:name,:postal_code,:address)
  end

end
end
