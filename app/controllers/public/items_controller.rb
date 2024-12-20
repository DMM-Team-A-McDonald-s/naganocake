class Public::ItemsController < ApplicationController

def index
  @total_items = Item.count

  if params[:genre_id].present?
    @genre = Genre.find(params[:genre_id])
    @items = Item.where(genre_id: params[:genre_id]).page(params[:page]).per(8)
  else
    @items = Item.page(params[:page]).per(8)
  end
end

def show
  @item = Item.find(params[:id])
  @cart_item = CartItem.new
end

end
