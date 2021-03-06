class ItemsController < ApplicationController
  def index
  	  @genres = Genre.where(is_enabled: true)
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.order(created_at: :desc).where(is_active: "販売中").page(params[:page]).per(5)
    else
      @items = Item.where(is_active: "販売中").page(params[:page]).per(5)
    end
  end
  


  def show
    @cart_item = CartItem.new
  	@genres = Genre.all
  	@item = Item.find(params[:id])
  end
  

end
