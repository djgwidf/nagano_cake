class AddressesController < ApplicationController
  def index
    @address_new = Address.new
    @address = current_customer.address
  end

  def edit
    @address = current_customer.address
  end

  def update
     if address.update(address_params)
      redirect_to index_address_path(current_customer)
     else
      flash[:genre_updated_error] = "ジャンル名を入力してください"
      redirect_to edit_address_path(current_customer)
     end
  end

private
  def address_params
      params.require(:address).permit(:last_name, :first_name, :postal_code, :address)
  end
end
