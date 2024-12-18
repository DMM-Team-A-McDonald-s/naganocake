class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @customer_address = address_display(@customer)
  end

  def confirm
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @payment = params[:order][:payment_method]
    @main_total = 0
    
    if params[:order][:address_option] == "1"
      @postal_code = address_display(@customer)
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
  end

  def create
    @payment = params[:order][:payment_method]
    @postal_code = params[:order][:postal_code]
    @address = params[:order][:address]
    @name = params[:order][:name]

    
  end

  def complete

  end

  private

  def address_display(customer)
    '〒' + customer.postal_code + ' ' + customer.address + ' ' 
  end

end
