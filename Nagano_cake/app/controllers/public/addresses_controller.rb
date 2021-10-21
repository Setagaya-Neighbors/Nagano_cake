class Public::AddressesController < ApplicationController
  def index
    @address = Address.all
    @new_address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to address_path(@book), notice: "You have created address successfully."
    else
      @address = Address.all
      render 'index'
    end
  end

  def edit
    @address = Address.find(params[:id])
    @new_address = Address.new(address_params)
  end

  def update
     @address = Address.find(params[:id])
     @address.update(address_params)
     redirect_to address_path(@address), notice: "You have updated address successfully."
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end
  
  private

  def address_params
    params.require(:address).permit(:name,:postal_code,:address)
  end

end
end
