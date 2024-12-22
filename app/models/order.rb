class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }

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
