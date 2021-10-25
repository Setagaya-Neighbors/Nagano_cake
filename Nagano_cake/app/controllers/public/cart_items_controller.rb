class Public::CartItemsController < ApplicationController

  def create #ItemsControllerのShowViewよりアクセス
    @infomation = params[:item ]
    @cart_item  = CartItem.new(cart_item_params)
    if CartItem.exists?(customer_id: current_customer.id, item_id: @infomation.item_id)                      #そのcustomerが同じitemを既にカートに入れているか判定
      @item_in_cart       = CartItem.find_by(customer_id: current_customer.id, item_id: @infomation.item_id) #trueの場合、既にカートに入っている同itemの個数と、今し方カートに入れたitemの個数を合算
      @cart_item          = @item_in_cart.update(quantity: @item_in_cart.quantity + @infomation.quantity)
      flash[:createdflag] = true
    else                                                                                                     #falseの場合、レコードを新規作成
      @cart_item.customer_id = current_customer.id
      @cart_item.item_id     = @infomation.item_id
      @cart_item.save
      flash[:createdflag]    = false                                                                         #redirect先でtrueパターンとは別のメッセージを表示させるため、便宜的にfalseと設定
    end

    redirect_to public_cart_items_path

  end

  def index
    @cart_items = CartItem.find_by(customer_id: current_customer.id)
    @items      = Item.find_by(id: @cart_items.id)
    @total      = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price } #cart_itemの合計金額を計算("sum_of_priceはmodelで")
  end

  def update
    @cart_item = CartItem.find(params[:item_id])
    @cart_item.update(CartItem_params)
    flash[:createdflag] = true
    redirect_to public_cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:item_id])
    @cart_item.destroy
    flash[:createdflag] = true
    redirect_to public_cart_items_path
  end

  def destroy_all
    if @cart_items = CartItem.where(customer_id: current_customer.id).destroy_all
      flash[:createdflag] = true
    else flash[:createdflag] = false
    end

    redirect_to public_cart_items_path
  end

  private

  def cart_item_params
    params.require(:CartItem).permit(:customer_id :item_id, :quantity)
  end

end
