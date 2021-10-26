class Public::ItemsController < ApplicationController
 PER = 8

  def index
     @items = Item.where(is_active: true).page(params[:page]).per(PER)

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
