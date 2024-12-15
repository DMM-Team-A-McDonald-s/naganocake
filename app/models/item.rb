class Item < ApplicationRecord
  TAX_RATE = 0.1
  
    def tax_included_price
    (price * (1 + TAX_RATE)).round
    end

    def status_label
      is_active ? "販売中" : "販売停止中"
    end
  end
