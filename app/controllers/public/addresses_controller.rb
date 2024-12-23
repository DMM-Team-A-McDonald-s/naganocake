class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def edit
    @address = current_customer.addresses.find(params[:id])
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to addresses_path, notice: "配送先住所が追加されました。"
    else
      @addresses = current_customer.addresses
      redirect_to addresses_path, notice: "エラー"
    end
  end

  def update
    @address = current_customer.addresses.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: "配送先が更新されました。"
    else
      @addresses = current_customer.addresses
      render :index
    end
  end

  def destroy
    @address = current_customer.addresses.find(params[:id])
    @address.destroy
    redirect_to addresses_path, notice: "配送先が削除されました。"
  end

  private
    def address_params
      params.require(:address).permit(:name, :postal_code, :address)
    end
end
