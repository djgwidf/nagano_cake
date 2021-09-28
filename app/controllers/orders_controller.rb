class OrdersController < ApplicationController


  def new
    @order = Order.new
    @address = Address.new
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end


  def create
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
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
      redirect_to orders_thankx_path
  end

  #def create_address
   # @address = Address.new(address_params)
    #@address.customer_id = current_customer.id
    #@address.save
    #redirect_to orders_log_path
  #end

  def log
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    #@order.payment_method = params[:payment_method]
    #binding.pry
    @order.postage = 800
    @total_price = calculate(current_customer)
    @order.price = @total_price
    if params[:select] == "my_address"
      @order.name = current_customer.last_name
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
    else
      #@address = Address.new
      #@address.name = params[:order][:name]
      #@address.address = params[:order][:address]
      #@address.postal_code = params[:order][:postal_code]
      #if @address.save
       # @order.name = @address.name
      #  @order.address = @address.address
      #  @order.postal_code = @address.postal_code
      #else
       # render 'new'
     # end
    end
    session[:payment_method] = params[:payment_method]

  end

  private
   def address_params
     params.require(:address).permit(:customer_id,:last_name, :first_name, :postal_code, :address)
   end
   def order_params
     params.require(:order).permit(:customer_id, :address, :payment_method, :price, :name, :postal_code, :postage)
   end

   def calculate(user)
     price = 0
     user.cart_items.each do |cart_item|
       price += cart_item.amount * cart_item.item.price
     end
     return (price * 1.1).floor
   end

 end
