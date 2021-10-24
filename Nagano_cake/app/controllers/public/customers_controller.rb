class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find_by(current_customer[:id])
  end

  def cancel
  end

  def withdraw
    @customer = Customer.find_by(current_customer[:id])
    @user.update(is_deleted: false)
    reset_session
    redirect_to root_path
  end

  def edit
    @customer = Customer.find_by(current_customer[:id])
  end

  def update
    @customer = Customer.find_by(current_customer[:id])
    if @customer.update(customer_params)
      flash[:createdflag] = true
      redirect_to public_customer_path(@customer.id)
    else
      render:edit
    end
  end

  private
  # ストロングパラメータ
  def customer_params
   params.require(:customer).permit(:last_name, :first_name, :last_name_ruby, :first_name_ruby, :email, :postal_code, :address, :phone_number, :is_deleted)
  end
end
