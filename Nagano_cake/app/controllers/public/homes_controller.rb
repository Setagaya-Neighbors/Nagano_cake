class Public::HomesController < ApplicationController

  def top
    @items = Item.all.order(id: "DESC").first(4)
    # 新着を上から4件取得

  end
end
