class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy

  TAX_RATE = 0.1
    def tax_included_price
    (price * (1 + TAX_RATE)).round
    end

    def status_label
      is_active ? "販売中" : "販売停止中"
    end
  end
