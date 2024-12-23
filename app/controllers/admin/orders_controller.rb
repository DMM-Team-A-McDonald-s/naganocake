class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_order, only: [:update, :show]

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if @order.status == "payment_confirmed"
        @order.order_details.update_all(making_status: :not_started)
      end
      redirect_to admin_order_path(@order)
    else
      render :show
    end
  end
    
  def show
    @order = Order.find(params[:id])
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:status)
    end

    def update_order_status
      @order.status ||= :waiting_for_payment
      if @order.order_details.all? { |detail| detail.completed? }
        @order.update(status: :ready_to_ship)
      elsif @order.order_details.any? { |detail| detail.in_production? }
        @order.update(status: :in_production)
      end
    end
end
