class Public::CartItemsController < ApplicationController

  def create #ItemsControllerのShowViewよりアクセス

    if p CartItem.exists?(customer_id: current_customer.id, item_id: params[:cart_item][:item_id])                        #そのcustomerが同じitemを既にカートに入れているか判定
      @item_in_cart       = CartItem.find_by(customer_id: current_customer.id, item_id: params[:cart_item][:item_id])   #trueの場合、既にカートに入っている同itemの個数と、今し方カートに入れたitemの個数を合算
      @cart_item          = @item_in_cart.update(quantity: @item_in_cart.quantity + params[:cart_item][:quantity].to_i)
      flash[:createdflag] = true
      redirect_to public_cart_items_path
    else                                                                                                                #falseの場合、レコードを新規作成
      p @cart_item  = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      if @cart_item.save
        flash[:createdflag]    = false                                                                                  #redirect先でtrueパターンとは別のメッセージを表示させるため、便宜的にfalseと設定
        redirect_to public_cart_items_path
      else
        redirect_to public_item_path(params[:cart_item][:item_id])
      end
    end

  end

  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @amount = 0 #合計金額の計算に使用

  end

  def update
    @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
    @cart_item.update(cart_item_params)
    flash[:createdflag] = true
    redirect_to public_cart_items_path
  end

  def destroy
    @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
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
    params.require(:cart_item).permit(:customer_id, :item_id, :quantity)
  end

end
