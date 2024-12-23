class Public::AddressesController < ApplicationController

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
      flash[:notice] = @address.errors.full_messages.join(", ")
      redirect_to addresses_path
    end
  end

  def update
    @address = current_customer.addresses.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: "配送先が更新されました。"
    else
      @addresses = current_customer.addresses
      render :edit
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
