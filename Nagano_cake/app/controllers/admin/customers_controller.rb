class Admin::CustomersController < ApplicationController
  def index
     @customer = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
     @customer = Customer.find(params[:id])

    if customer.update(customer_params)
      flash[:createdflag] = true
      redirect_to admin_customer_path(customer.id)
    else
      @customer=customer
      render:edit
    end 
  end


private
  # ストロングパラメータ
  def customer_params
   params.require(:customer).permit(:last_name, :first_name, :last_name_ruby, :first_name_ruby, :email, :postal_code, :address, :phone_number, :encrypted_password, :is_deleted)
   params.require(:address).permit(:name, :address, :postal_code)
  end

end
