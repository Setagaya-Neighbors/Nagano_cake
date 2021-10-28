class Admin::OrdersController < ApplicationController

  def show
    @order        = Order.find(params[:id])
    @order_detail = OrderDetail.where(order_id: @order.id)
    @total = 0
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if @order.status == "comfirmed" #注文ステータスが"入金確認"になったら、受注ステータスを"製作待ち"に更新
         @order.order_details.update(making_status: "waiting_for_cooking")
      end
      flash[:createdflag] = true
      redirect_to admin_order_path(@order.id)
    else
      flash[:false] = "注文ステータスの更新に失敗しました。もう一度お試し下さい。"
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end


end
