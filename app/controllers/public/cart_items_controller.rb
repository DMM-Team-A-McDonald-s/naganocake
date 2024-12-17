class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def create
    if CartItem.find_by(item_id: params[:cart_item][:item_id], customer_id: current_customer.id).nil?
      # カート内に同じアイテムがある場合は数量のみを追加するための条件分岐
      @cart_item = CartItem.new(cart_item_params)
      if @cart_item.save
        redirect_to cart_items_path
      else
        redirect_to items_path
        # ここは仮
      end
    else
      @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id], customer_id: current_customer.id)
      @cart_item.amount = @cart_item.amount + params[:cart_item][:amount].to_i
      @cart_item.save
      redirect_to cart_items_path
      # 同じアイテムがあった場合amountのみを追加して保存する
    end

  end

  def destroy

  end

  def destroy_all
    cart_items =  CartItem.where(customer_id: current_customer.id)
    cart_items.destroy_all
    redirect_to cart_items_path
  end

  private 
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
