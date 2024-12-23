class Address < ApplicationRecord
  belongs_to :customer

  validates :name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]{1,20}\z/, message: 'は１文字以上の全角のひらがな、カタカナ、漢字のみで入力してください。' }
  validates :postal_code, format: { with: /\A\d{7}\z/, message: 'は7桁の半角数字のみで入力してください。' }
  validates :address, presence: true, length: { maximum: 255 }
  
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
end
