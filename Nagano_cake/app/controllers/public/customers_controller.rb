class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def cancel
    @customer = Customer.find(name: params[:name])
  end

  def withdraw
    @customer = Customer.find(name: params[:name])
    @user.update(is_valid: false)
    reset_session
    redirect_to public_customer_path
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
     @customer = Customer.find(params[:id])
    if customer.update(customer_params)
      flash[:createdflag] = true
      redirect_to public_customer_path(customer.id)
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
