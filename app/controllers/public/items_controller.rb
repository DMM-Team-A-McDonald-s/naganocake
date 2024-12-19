class Public::ItemsController < ApplicationController

def index
  @total_items = Item.count

  if params[:genre_id].present?
    @items = Item.where(genre_id: params[:genre_id])
  else
    @items = Item.page(params[:page]).per(8)
  end
end

def show
  @item = Item.find(params[:id])
  @cart_item = CartItem.new
end

end
