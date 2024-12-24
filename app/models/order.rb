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

  validates :name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]{2,20}\z/, message: 'は２文字以上の全角のひらがな、カタカナ、漢字のみで入力してください。' }
  validates :postal_code, format: { with: /\A\d{7}\z/, message: 'は7桁の半角数字のみで入力してください。' }
  validates :address, presence: true, length: { maximum: 255 }
  validates :payment_method, presence: true

  def subtotal
    item.with_tax_price * amount
  end

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
end
