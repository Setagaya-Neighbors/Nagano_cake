class Public::ItemsController < ApplicationController

  def index
     @items = Item.all
     @cart_items = CartItem.all

  end

  def show
    @item = Item.find(params[:id])
    @customer = Customer.find_by(id: current_customer.id)
    @cart_item = CartItem.new
  end

end
