class AddressesController < ApplicationController
  def index
    @address_new = Address.new
    @address = current_customer.address
  end
  
  def edit
  end
  
  def create
  end
  
  def update
  end
  
  def destroy
  end
  
private
  
end
