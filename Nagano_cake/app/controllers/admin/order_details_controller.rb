class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = Orderdetail.find(params[:id])
    @order_detail.update(order_detail_params)
    flash[:createdflag] = true
    redirect_to admin_order_path(@order_detail.order_id)
  end

  private

  def order_detail_params
    params.require(:orderdetail).permit(:making_status)
  end



end
