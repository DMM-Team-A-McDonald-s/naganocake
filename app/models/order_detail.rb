class OrderDetail < ApplicationRecord
  enum making_status: {
    unable_to_start: 0, # 着手不可(デフォルト)
    not_started: 1,    # 製作待ち
    in_production: 2,  # 製作中
    completed: 3       # 製作完了
  }

  belongs_to :order
  belongs_to :item
  
  before_create :set_default_making_status
  after_update :update_order_status

  private
    def set_default_making_status
      self.making_status ||= :unable_to_start
    end
    
    def update_order_status
      order = self.order
      if order.order_details.any? { |detail| detail.in_production? }
        order.update(status: :in_production)
      elsif order.order_details.all? { |detail| detail.completed? }
        order.update(status: :ready_to_ship)
      end
    end
end
