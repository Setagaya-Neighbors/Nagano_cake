class Public::OrdersController < ApplicationController

  def index
    @orders = Order.find_by(customer_id: current_customer.id)
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = @Orderdetail.find_by(order_id: @order.id)
  end

  def new
    @order = Order.new
    params[:item_id, :item_name, :price, :quantity, :total] #CartItems#createから取得する
    @address = Address.find_by(customer_id: current_customer.id)
    @new_address = Address.new
  end

  def confirm
    @infomaion = params[:item_id, :item_name, :price, :quantity, :total, :payment, :postal_code, :address, :customer_name] #Orders#newから取得する
    if params[:shipping_address] == 2
      @new_address = Address.new #新しく配送先を登録する場合のみnewアクション実行
    end
    @order = Order.new
  end

  def create
    @infomaion = params[:item_id, :item_name, :price, :quantity, :total, :payment, :postal_code, :address, :customer_name] #Orders#confirmから取得する
    # orderの保存
    @order = Order.new(order_params)
      @order.customer_id    = current_customer.id
      @order.postage        = 800
      @order.payment        = @infomaion.payment
      @order.status         = "入金待ち"
      @order.billing_amount = @infomaion.total

      # 配送先のラジオボタンの選択により、Orderの配送先住所の保存対象を分岐する

      # 自分の住所の場合
      if params[:shipping_address] == 0
       @order.postal_code = current_customer.postal_code
       @order.address     = current_customer.address
       @order.name        = current_customer.name
      # /自分の住所の場合
      # 配送先として登録済みの住所から選ぶ場合
      elsif params[:shipping_address] == 1
        @order.postal_code = @infomaion.postal_code
        @order.address     = @infomaion.address
        @order.name        = @infomaion.name
      # /配送先として登録済みの住所から選ぶ場合
      # 新しく配送先を登録する場合
      elsif params[:shipping_address] == 2
        #新しい配送先の登録
        @new_address = Address.new(address_params)
          @new_address.postal_code = @infomaion.postal_code
          @new_address.address     = @infomaion.address
          @new_address.name        = @infomaion.name
        @new_address.save
        #/新しい配送先の登録
        # 新しい配送先をorderに反映
        @order.postal_code = @new_address.postal_code
        @order.address     = @new_address.address
        @order.name        = @new_address.name
        # /新しい配送先をorderに反映
      # /新しく配送先を登録する場合
      end
      # /配送先のラジオボタンの選択により、Orderの配送先住所の保存対象を分岐する

    @order.save
    # /orderの保存

    # order_detailの保存
    @order_detail = Orderdetail.new(order_detail_params)
      @order_detail.order_id       = @order.id
      @order_detail.item_id        = @infomaion.item_id
      @order_detail.making_status  = "着手不可"
      @order_detail.price_on_order = @infomaion.price
      @order_detail.item_quantity  = @infomation.quantity
    if  @order_detail.each do |order_deatil|
          order_detail.save
        end
      # cart_itemの削除
      @cart_item = CartItem.find_by(customer_id :current_customer.id)
      @cart_item.destroy_all
      # /cart_itemの削除
      redirect_to public_order_complete_path
    else
      flash[:createdflag] = false
      redirect_to public_items_path
    end
    # /order_detailの保存
  end


  def complete
  end


  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :postage, :payment, :billing_amount, :status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :making_status, :price_on_order, :item_quantity)
  end

end