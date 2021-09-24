class OrdersController < ApplicationController
  def index
    @order = Order.where(customer_id:current_customer)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details

  end

  def new
    @order = Order.new
    @address = Address.new
  end

  def create
   session[:payment] = params[:payment]
    if params[:select] == "select_address"
      session[:address] = params[:address]
    elsif params[:select] == "my_address"
     session[:address] ="〒" + current_customer.postal_code + current_customer.address + current_customer.last_name + current_customer.first_name
    end
    if session[:address].present? && session[:payment].present?
      redirect_to orders_log_path
    else
      flash[:order_new] = "支払い方法と配送先を選択して下さい"
      redirect_to new_order_path
    end
  end

  def log
      @orders = current_customer.orders
      @total_price = calculate(current_customer)

      if  session[:address].length <8
        @address = Address.find(session[:address])
      end
  end

  def create_address
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to new_order_path
  end


  def create_order
    @order = Order.new
    @order.customer_id = current_customer.id
    @order.address = session[:address]
    @order.payment = session[:payment]
    @order.total_price = calculate(current_customer)
    @order.save

    current_customer.cart_items.each do |cart|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_name = cart.item.name
      @order_detail.item_price = cart.item.price
      @order_detail.amount = cart.amount
      @order_detail.item_status = 0
      @order_detail.save

    end
    current_customer.cart_items.destroy_all
    session.delete(:address)
    session.delete(:payment)
    redirect_to thanks_path
  end

  private
   def ship_address_params
     params.require(:ship_address).permit(:customer_id,:last_name, :first_name, :postal_code, :address)
   end
   def order_params
     params.require(:order).permit(:customer_id, :address, :payment, :total_price)
   end

   # 商品合計（税込）の計算
   def calculate(user)
     total_price = 0
     user.cart_items.each do |cart_item|
       total_price += cart_item.amount * cart_item.item.price
     end
     return (total_price * 1.1).floor
   end

end
