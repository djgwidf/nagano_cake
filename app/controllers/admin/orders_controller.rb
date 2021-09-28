class Admin::OrdersController < ApplicationController
before_action :authenticate_admin!

 def index
  @orders = Order.page(params[:page]).per(10)
 end

 def show
  @order = Order.find(params[:id])
  @order_details = @order.order_details.all
 end

private
 def order_params
  #params.require(:order).permit(:)
 end

end