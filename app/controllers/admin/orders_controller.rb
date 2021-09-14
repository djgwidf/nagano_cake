class Admin::OrdersController < ApplicationController

  def index
    if
      params[:id]
      @orders = Customer.find(params[:id]).orders.page(params[:page]).per(10)
    elsif
      request.fullpath.include? "today" # TOP本日受注分から来た場合
      @orders = Order.where(created_at:  Time.zone.now.all_day).page(params[:page]).per(10)
    elsif
      request.fullpath.include? "yesterday" # TOP本日製作分から来た場合
      @orders = Order.where(created_at: 1.day.ago.all_day).page(params[:page]).per(10)
    else
      @orders = Order.page(params[:page]).per(10)
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @items_total_price = calculate(@order)
  end

private
  def ship_address_params
     params.require(:ship_address).permit(:customer_id,:last_name, :first_name, :post_code, :address)
  end
  def order_params
     params.require(:order).permit(:customer_id, :address, :payment, :carriage, :total_price, :order_status)
  end

end
