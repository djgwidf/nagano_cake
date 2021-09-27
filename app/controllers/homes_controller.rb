class HomesController < ApplicationController



  def top
     @items = Item.where(is_active: "販売中")
     @genres = Genre.all
  end

  def about
  end

private

  def item_params
    params.require(:item).permit(:name, :price, :introduction, :image_id, :is_active, :genre_id)
  end

  def ensure_active_item
     items = Item.joins(:genre).where
    unless items.any? { |p| p == Item.find(params[:id]) }
      redirect_back(fallback_location: root_path)
    end
  end
end
