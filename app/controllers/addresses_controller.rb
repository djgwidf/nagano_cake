class AddressesController < ApplicationController
  def index
    @address = current_customer.address
  end

  def edit
    @address = current_customer.address

  end

  def create
  end

  #def update
    #@address = current_customer.address
     #if
       #@address.update( )
      #redirect_to addresses_path
     #else
      #flash[:address_updated_error] = "入力してください"
      #redirect_to index_address_path
     #end
  #end

private
  def address_params
      params.require(:address).permit(:last_name, :first_name, :postal_code, :address)
  end
end
