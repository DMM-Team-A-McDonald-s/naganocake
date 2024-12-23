class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]

def index
  @total_items = Item.count
  @genres = Genre.all

  if params[:genre_id].present?
    @genre = Genre.find(params[:genre_id])
    @items = Item.where(genre_id: params[:genre_id]).page(params[:page]).per(8)
  else
    @items = Item.page(params[:page]).per(8)
  end
end

def show
  @item = Item.find(params[:id])
  @genres = Genre.all
  @cart_item = CartItem.new
end

end
