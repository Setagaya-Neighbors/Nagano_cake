class Admin::OrderDetailsController < ApplicationController
  
  def update
    @order_detail = Orderdetail.find(params[:id])
    if @order_detail.update(order_detail_params)
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
    params.require(:orderdetail).permit(:making_status)
  end



end
