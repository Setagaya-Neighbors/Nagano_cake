class Admin::GenresController < ApplicationController

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
     @genre = Genre.new(item_params)

    if @genre.save

      #createflag＝trueは、ジャンルを作りShowページに飛んだときに動くように定義
      flash[:createdflag] = true
      redirect_to admin_genres_path(@genre.id)
    else
      @genres=Genre.all
      render:index
    end
  end

  def edit
      @genre = Genre.find(params[:id])

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

  def item_params
    params.permit(:name, :description ,:image_id, :price, :is_active)

  end


end
