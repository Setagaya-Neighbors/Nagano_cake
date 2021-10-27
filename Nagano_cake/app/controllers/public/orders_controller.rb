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
    @address = Address.where(customer_id: current_customer.id)
    @new_address = Address.new
  end

  def confirm
    @cart_item = CartItem.where(customer_id: current_customer.id) #Orders#newからCartItemのidを取得する
  p @order = Order.new
  p @order.payment = params[:address][:payment].to_i

    # 配送先の選択によって取得する住所を決定
    if params[:address][:shipping_address] == "0" #自分の住所だった場合
        @address             = Customer.find_by(id: current_customer.id)
        @order.postal_code   = current_customer.postal_code
        @order.address       = current_customer.address
        @order.name          = current_customer.name
    elsif params[:address][:shipping_address] == "1" #登録済住所だった場合
        @address = Address.find_by(id: params[:address][:registerd_address], customer_id: current_customer.id)
        @order.postal_code   = @address.postal_code
        @order.address       = @address.address
        @order.name          = @address.name
    elsif  params[:address][:shipping_address] == "2" #新しく登録する住所だった場合
      @address = Address.new(address_params)
        @address.postal_code =  params[:address][:postal_code]
        @address.address     =  params[:address][:address]
        @address.name        =  params[:address][:name]
      @address.save
    end
    # /配送先の選択によって取得する住所を決定

    # View内での金額計算用
    @tax_in_amount  = 0
    @total          = 0
    @billing_amount = 0
    # /View内での金額計算用

    if params[:address][:shipping_address] == "2"
      @new_address = Address.new #新しく配送先を登録する場合のみnewアクション実行
    end
  end

  def create
    # orderの保存
    @order = Order.new(order_params)
      @order.customer_id    = current_customer.id
      @order.postage        = 800
      @order.status         = 0
      @order.billing_amount = params[:order][:billing_amount].to_i
    # /orderの保存

    # order_detailの保存
    @cart_item    = CartItem.where(customer_id: current_customer.id)
    @item_id      = @cart_item.select(:item_id)
    @item         = Item.where(id: @item_id)

    if  @order.save
      @cart_item.each do |cart_item|
        @order_detail                = OrderDetail.new(order_detail_params)
        @order_detail.order_id       = @order.id
        @order_detail.item_id        = cart_item.item_id
        @order_detail.making_status  = 0
        @order_detail.price_on_order = (cart_item.item.price * 1.08).round
        @order_detail.item_quantity   = cart_item.quantity
        @order_detail.save
      end
      # cart_itemの削除
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
    params.permit(:order_id, :item_id, :making_status, :price_on_order, :item_quantity)
  end

end