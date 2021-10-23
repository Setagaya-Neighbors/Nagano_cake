class Public::ItemsController < ApplicationController

  def index
     @items = Item.all
     @cart_items = Cart_item.all

  end

  def show
    @item = Item.find(params[:id])

  end

  private
  # ストロングパラメータ
  def item_params
    params.require(:item).permit(:name, :description)
  end
end
