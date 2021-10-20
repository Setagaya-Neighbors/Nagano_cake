class Admin::ItemsController < ApplicationController

  def index
     @item_images = Item.all
     @items = Item.all
     @item = Item.new
     @cart_items = Cart_item.all
     @order_details = Order_detail.all
  end

  def new
     @item = Item.new
  end

  def create
    @item_image = Item.new(item_image_params)
    @item_image.save

     @item = Item.new(item_params)
    if @item.save
      flash[:createdflag] = true
      redirect_to item_path(@item.id)
    else
      @items=Item.all
      render:index
    end
  end

  def show
    @item = Item.find(params[:id])
    @items = Item.all
    @newitem = Item.new
  end

  def edit
    @items = Item.all
    @item = Item.find(params[:id])
    unless @item.genre == current_genre
    redirect_to items_path
    end
  end

  def update
     item = Item.find(params[:id])

    if item.update(item_params)
      flash[:createdflag] = true
      redirect_to item_path(item.id)
    else
      @item=item
      render:edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path
  end

private
  # ストロングパラメータ
  def item_params
    params.require(:item).permit(:name, :description)
  end

end
