class Public::AddressesController < ApplicationController

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def create
    Rails.logger.debug "PARAMS: #{params.inspect}"
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to addresses_path, notice: "配送先住所が追加されました。"
    else
      @addresses = current_customer.addresses
      render :index
    end
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: "配送先住所が追加されました。"
    else
      render :edit
    end
  end
  
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
      redirect_to addresses_path, notice: "配送先住所が削除されました。"
  end
  
  private
    def address_params
      params.require(:address).permit(:name, :postal_code, :address)
    end
  end

