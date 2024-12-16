class Public::ItemsController < ApplicationController

def index
  @items = Item.page(params[:page]).per(8)
  @total_items = Item.count
end

def show
  @item = Item.find(params[:id])
end

end
