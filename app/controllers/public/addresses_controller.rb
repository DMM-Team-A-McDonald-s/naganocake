class Public::AddressesController < ApplicationController

  def index
    @addresses = Address.all
  end
  
  def edit
    @addresse = Address.find(params[:id])
  end
  
  def create
    @addresse = current_customer.addresses.new(address_params)
    if @addresse.save
      redirect_to addresses_path, notice: "配送先住所が追加されました。"
    else
      render :index
    end
  end
  
  def update
    @addresse = Address.find(params[:id])
    @addresse.update(address_params)
      redirect_to addresses_path(customer_id)
  end
  
  def destroy
    @addresse = Address.find(params[:id])
    @addresse.destroy
      redirect_to addresses_path(customer_id)
  end
  
  private
    def address_params
      params.require(:address).permit(:name, :postal_code, :address)
    end
  end
  

end
