class Public::HomesController < ApplicationController

  def top
    p @order = Order.new
    p @address = Address.where(customer_id: current_customer.id)
    p @new_address = Address.new
  end

end
