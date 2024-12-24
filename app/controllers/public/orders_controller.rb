class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    cart_item = CartItem.find_by(customer_id: current_customer.id)
    if cart_item.present?
      @order = Order.new
      @customer = Customer.find(current_customer.id)
      @customer_address = address_display(@customer)
    else
      redirect_to request.referer
    end
  end

  def confirm
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @payment = params[:order][:payment_method]
    @main_total = 0

    
      if params[:order][:address_option] == "1"
        @postal_code =@customer.postal_code
        @address = @customer.address
        @address_name = @customer.last_name + @customer.first_name
      elsif params[:order][:address_option] == "2"
        address_id = params[:order][:address_id]
        customer_address = Address.find(address_id)
        @postal_code = customer_address.postal_code
        @address = customer_address.address
        @address_name = customer_address.name
      elsif params[:order][:address_option] == "3"
        @postal_code = params[:order][:postal_code]
        @address = params[:order][:address]
        @address_name = params[:order][:name]
      end
    if @postal_code.nil? && @address.nil? && @address_name.nil? && @payment.nil?
      redirect_to request.referer
    end
    
  end

  def create
    @postal_code = params[:order][:postal_code]
    @address = params[:order][:address]
    @name = params[:order][:name]
    @payment_method = params[:order][:payment_method]

    @cart_items = CartItem.where(customer_id: current_customer.id)
    if @postal_code.present? && @address.present? && @name.present? && @payment_method.present?
      total_cost = 0
      @cart_items.each do |cart_item|
        sub_cost =  cart_item.item.price * 1.1 * cart_item.amount.floor
        total_cost += sub_cost
      end
      @total_payment = total_cost + 800

      order = Order.new(order_params)
      order.save

      @cart_items.each do |cart_item|
        OrderDetail.create(
          order_id: order.id, item_id: cart_item.item.id, price: cart_item.item.price * 1.1, amount: cart_item.amount, making_status: 0
        )
      end
      
      @cart_items.destroy_all

      redirect_to complete_orders_path
    else
    redirect_to request.referer

    end

  end

  def complete

  end

  def index
    @orders = current_customer.orders
    @order_items = Order.where(customer_id: current_customer.id)
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details
  end

  private

  def address_display(customer)
    '〒' + customer.postal_code + ' ' + customer.address + ' ' 
  end

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name,
    :shipping_cost, :total_payment, :payment_method, :status).merge(
      customer_id: current_customer.id, postal_code: @postal_code, address: @address, name: @name,
       shipping_cost: 800, total_payment: @total_payment, payment_method: @payment_method, status: 0
    )
  end

  # def order_detail_params
  #    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status)
  # end

end
