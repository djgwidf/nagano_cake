class Admin::ItemsController < ApplicationController

  def inex
    @item = Item.
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params[:id])
    if @item.save
      redirect_to admin_items_path
    else
      redirect_to new_admin_item_path
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :image_id, :name, :introduction, :price, :is_active)
  end


end

