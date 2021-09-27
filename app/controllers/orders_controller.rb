class OrdersController < ApplicationController
  def index
    @orders = current_customer.orders.all

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
   session[:payment_method] = params[:payment_method]
    if params[:select] == "select_address"
      session[:address] = params[:address]
    elsif params[:select] == "my_address"
     session[:address] ="〒" + current_customer.postal_code + current_customer.address + current_customer.last_name + current_customer.first_name
    end
    if session[:address].present? && session[:payment_method].present?
      redirect_to orders_log_path
    else
      flash[:order_new] = "支払い方法と配送先を選択して下さい"
      redirect_to new_order_path
    end
  end

  def log
    @order = Order.new
    @order.customer_id = current_customer.id
    @orders = current_customer.orders
    @order.payment_method = session[:payment_method]
    @order.postage = 800
    @total_price = calculate(current_customer)
    @order.price = @total_price
      binding.pry
    if params[:select] == "my_address"
      @order.name = current_customer.last_name
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
    end
  end

  def create_address
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to new_order_path
  end


  def create_order
    @order.address = session[:address]

    @order.price = calculate(current_customer)

    binding.pry
    @order.save

    current_customer.cart_items.each do |cart|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart.item.id
      @order_detail.unit_price = cart.item.price
      @order_detail.amount = cart.amount
      @order_detail.save

    end
    current_customer.cart_items.destroy_all
    session.delete(:address)
    session.delete(:payment_method)
    redirect_to orders_thanks_path
  end

  private
   def address_params
     params.require(:address).permit(:customer_id,:last_name, :first_name, :postal_code, :address)
   end
   def order_params
     params.require(:order).permit(:customer_id, :address, :payment_method, :total_price)
   end

   def calculate(user)
     price = 0
     user.cart_items.each do |cart_item|
       price += cart_item.amount * cart_item.item.price
     end
     return (price * 1.1).floor
   end

end
