class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details
  has_many :orders, through: :order_details

  validates :name, presence:true
  validates :introduction, presence:true, length: {maximum: 200}
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  def with_tax_price
    (price * 1.1).floor
  end
  # 消費税を求めるメソッド

  TAX_RATE = 0.1
    def tax_included_price
    (price * (1 + TAX_RATE)).round
    end

    def status_label
      is_active ? "販売中" : "販売停止中"
    end
end
