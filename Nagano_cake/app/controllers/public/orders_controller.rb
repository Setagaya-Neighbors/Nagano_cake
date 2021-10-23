class Public::OrdersController < ApplicationController

  def index
    @orders = Order.find_by(customer_id: current_customer.id)
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = @Orderdetail.find_by(order_id: @order.id)
  end

  def new
    @customer = Customer.find_by(id: current_customer.id)
    @address = Address.find_by(customer_id: current_customer.id)
    @new_address = Address.new
    @order = Order.new
  end
  
  def confirm
    @customer = Customer.find_by(id: current_customer.id)
    @address = Address.find_by(customer_id: current_customer.id)
    @new_address = Address.new
    @order = Order.new
  end

  def create
    @customer = Customer.find_by(id: current_customer.id)
    @address = Address.find_by(customer_id: current_customer.id)
    @new_address = Address.new(address_params)
    @order = Order.new(order_params)
    
  end

  

  def complete
  end


  private


end
