class Public::AddressesController < ApplicationController
  def index
    @address = Address.all
    @new_address = Address.new
  end

  def create
    @address = Address.new(address_params)
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to book_path(@address), notice: "You have updated address successfully."
    else
      render "edit"
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end
end
