class Public::ItemsController < ApplicationController

  def index
     @items = Item.all
     @item = Item.new
     @cart_items = Cart_item.all
     @order_details = Order_detail.all
  end

  def show
    @item = Item.find(params[:id])
    @items = Item.all
  end

  private
  # ストロングパラメータ
  def item_params
    params.require(:item).permit(:name, :description)
  end
end
