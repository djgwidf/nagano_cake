class AddressesController < ApplicationController
  def index
    @address = current_customer.address
    @addresses = Address.all
  end

  def edit
    @address = current_customer.address

  end

  def create
  end

  def update
    @address = current_customer.address
     if
       @address.update(address_params)
      redirect_to addresses_path
     else
      flash[:address_updated_error] = "入力してください"
      redirect_to edit_address_path(current_customer)
     end
  end

private
  def address_params
      params.require(:address).permit(:last_name, :first_name, :postal_code, :address)
  end
end
