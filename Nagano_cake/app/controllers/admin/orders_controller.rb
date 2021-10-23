class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_detail = Orderdetail.find_by(order_id: @order.id)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
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
