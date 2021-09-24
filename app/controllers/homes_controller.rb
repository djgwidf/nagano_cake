class HomesController < ApplicationController
  before_action :authenticate_customer!, except: [:top]



  def top
     @items = Item.where(is_active: "販売中")
  end

  def about
  end
end
