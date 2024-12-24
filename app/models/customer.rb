class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :last_name, :first_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]{1,20}\z/, message: 'は１文字以上の全角のひらがな、カタカナ、漢字のみで入力してください。' }

  validates :last_name_kana, :first_name_kana, format: { with: /\A[\p{katakana}\p{blank}ー－]{1,20}\z/, message: 'は１文字以上のカタカナで入力して下さい。' }

  validates :postal_code, format: { with: /\A\d{7}\z/, message: 'は7桁の半角数字のみで入力してください。' }
  
  validates :address, length: { maximum: 255 }, presence:{ message: 'は必須項目です。' }

  validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁または11桁の半角数字のみで入力してください。' }

end
