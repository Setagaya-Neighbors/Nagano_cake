class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      if @order_detail.making_status == "on_going"
        @order_detail.order.update(status: "on_going")
      elsif @order_detail.order.order_details.all? {|order_detail| order_detail.making_status == "complete"}
        @order_detail.order.update(status: "ready_for_shipping")
      end
      flash[:createdflag] = true
      redirect_to admin_order_path(@order_detail.order_id)
    else
      @order = Order.find(pramas[:id])
      render "order/show"
      flash[:false] = "製作ステータスの更新に失敗しました。もう一度お試し下さい。"
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end


end
