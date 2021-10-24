class Public::CartItemsController < ApplicationController

  def create #ItemsControllerのShowViewよりアクセス
    @item = Item.find(params[:id])
    @cart_item = Cartitem.new(cart_item_params)
    if Cartitem.exists?(customer_id: current_customer.id, item_id: @item.id)                #そのcustomerが同じitemを既にカートに入れているか判定
      @item_in_cart = Cartitem.find_by(customer_id: current_customer.id, item_id: @item.id) #trueの場合、既にカートに入っている同itemの個数と、今し方カートに入れたitemの個数を合算
      @cart_item = @item_in_cart.update(quantity: @item_in_cart.quantity + @cart_item.quantity)
      flash[:createdflag] = true
    else                                                                                     #falseの場合、レコードを新規作成
      @cart_item.customer_id = current_customer.id
      @cart_item.item_id = @item.id
      @cart_item.save
      flash[:createdflag] = false                                                            #redirect先でtrueパターンとは別のメッセージを表示させるため、便宜的にfalseと設定
    end

    redirect_to public_item_path(@item.id)

  end

  def index
    @cart_items = Cartitem.find_by(customer_id: current_customer.id)
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price } * 1.08 #cart_itemの合計金額を計算("sum_of_priceはmodelで")
  end

  def update
    @cart_item = Cartitem.find(params[:item_id])
    @cart_item.update(Cartitem_params)
    flash[:createdflag] = true
    redirect_to public_cart_items_path
  end

  def destroy
    @cart_item = Cartitem.find(params[:item_id])
    @cart_item.destroy
    flash[:createdflag] = true
    redirect_to public_cart_items_path
  end

  def destroy_all
    if @cart_items = Cartitem.where(customer_id: current_customer.id).destroy_all
      flash[:createdflag] = true
    else flash[:createdflag] = false
    end

    redirect_to public_cart_items_path
  end

  private

  def cart_item_params
    params.require(:Cartitem).permit(:customer_id, :item_id, :quantity)
  end

end
