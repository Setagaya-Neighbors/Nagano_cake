class Admin::ItemsController < ApplicationController

  def index
     @items = Item.all
  end

  def new
     @item = Item.new
     @genre = Genre.all
  end

  def create

     @item = Item.new(item_params)

    if @item.save
      flash[:createdflag] = true
      redirect_to admin_item_path(@item.id)
    else
      @items=Item.all
      render:index
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit

    @item = Item.find(params[:id])

  end

  def update
     @item = Item.find(params[:id])

    if item.update(item_params)
      flash[:createdflag] = true
      redirect_to admin_item_path(item.id)
    else
      @item=item
      render:edit
    end
  end



private
  # ストロングパラメータ
  def item_params
   params.require(:item).permit(:name, :description ,:image, :price, :is_active, :genre_id)

  end


end
