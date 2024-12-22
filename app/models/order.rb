class Order < ApplicationRecord
  enum payment_method: {
    credit_card: 0,
    transfer: 1 
  }

  enum status: {
    waiting_for_payment: 0, # 入金待ち (デフォルト)
    payment_confirmed: 1,   # 入金確認
    in_production: 2,       # 製作中
    ready_to_ship: 3,       # 製作完了
    shipped: 4              # 発送済み
  }

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  def subtotal
    item.with_tax_price * amount
  end

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
end
