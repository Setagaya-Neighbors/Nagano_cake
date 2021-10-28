class Public::ItemsController < ApplicationController
 PER = 8

  def index
   @items = Item.where(is_active: true).page(params[:page]).per(PER)
  end

  def show
    @item = Item.find(params[:id])
    @customer = Customer.find_by(id: current_customer.id)
    @cart_item = CartItem.new
  end

end
