class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.all
    @genre = Genre.new
    @items = Item.all
    @item = Item.new
  end

  def create
     @item = Item.new(item_params)
     @item.genre_id = current_genre.id
    if @item.save
      flash[:createdflag] = true
      redirect_to item_path(@item.id)
    else
      @items=Item.all
      render:index
    end
  end

  def edit
      @genre = Genre.find(params[:id])
    if @genre != current_genre
      redirect_to genre_path(current_genre)
    end
  end

  def update
       @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:createdflag] = true
      flash[:notice]= "You have updated user successfully."
      redirect_to genre_path(@genre.id)

    else

      render:edit

    end
  end

end
